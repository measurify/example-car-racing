# Imports
import cv2
import math
import requests
import time

login_url = 'https://students.measurify.org/v1/login'
measurement_url = 'https://students.measurify.org/v1/measurements'


def login():
    
    response = requests.post(login_url, data= {
        'username' : "car-manager-user-username",
        'password' : "car-manager-user-password",
        'tenant' : "car-manager-tenant"
    })
    print(response.status_code)
    response = response.json()
    return response["token"]



def send_measurify(millis, car):

    r = requests.post(measurement_url, json= {
    'thing': car,
    'feature': 'check-point',
    'device': 'car-device',
    "samples": ([ { 'values': [millis, '01'] }])
    }, headers={'Authorization' : token})
    print(r.status_code)
    print(r.json()) 
    return r.status_code

def detect_point(point):
    color = ""
    if point < 33:
        color = "RED"
    elif point < 78:
        color = "GREEN"
    elif point < 131:
        color = "BLUE"
    else:
        color = "RED"
    return color    


def detect(frame, pt, dist):
    hsv_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    red = 0
    blue = 0
    green = 0


    initial_point = [0,0]
    end_point = [0,0]

    initial_point[0] = pt[0]-int(dist/2)
    initial_point[1] = pt[1]-int(dist/2)

    end_point[0] = pt[0]+int(dist/2)
    end_point[1] = pt[1]+int(dist/2)


    for point_x in range(initial_point[0], end_point[0]):
        for point_y in range(initial_point[1], end_point[1]):
            pixel = hsv_frame[point_y,point_x]
            hue_value = pixel[0]
            color = detect_point(hue_value)
            if color == "RED":
                red += 1
            elif color == "BLUE":
                blue += 1
            else:
                green += 1
    if green > blue:
        if green > red:
            color = "GREEN"
            car = "Car 03"
        else:
           color = "RED"
           car = "Car 01"
    elif blue > red:
        color = "BLUE"
        car = "Car 02"
    else:
        color = "RED"
        car = "Car 01"          

    print("RED", red)
    print("BLUE", blue)
    print("GREEN", green)
    return car

def getTime(start):
    moment = time.time()
    millis = int((moment-start) * 1000)
    return millis

# Initialize Car Detection
cap = cv2.VideoCapture(1)
#cap = cv2.VideoCapture("porschecup.mp4")
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)
car_cascade = cv2.CascadeClassifier('haarcascade_cars.xml')
token = login()


# Initialize count, Ids and objects to detect
count = 0
center_points_prev_frame = []
tracking_objects = {}
track_id = 0
start = time.time()

while True:
    ret, frame = cap.read()
    count += 1
    if not ret:
        break

    # Point current frame
    center_points_cur_frame = []
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    # Detect objects on frame
    #boxes = car_cascade.detectMultiScale(gray, 1.1, 3,)
    boxes = car_cascade.detectMultiScale(gray,1.1,10)

    # Visualize boxes around cars
    for box in boxes:
        (x, y, w, h) = box
        cx = int((x + x + w) / 2)
        cy = int((y + y + h) / 2)
        center_points_cur_frame.append((cx, cy))

        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)


    # Only at the beginning we compare previous and current frame
    if count <= 2:
        for pt in center_points_cur_frame:
            for pt2 in center_points_prev_frame:
                distance = math.hypot(pt2[0] - pt[0], pt2[1] - pt[1])

                if  distance < 20:
                    tracking_objects[track_id] = pt
                    track_id += 1
    else:

        tracking_objects_copy = tracking_objects.copy()
        center_points_cur_frame_copy = center_points_cur_frame.copy()

        for object_id, pt2 in tracking_objects_copy.items():
            object_exists = False
            for pt in center_points_cur_frame_copy:
                distance = math.hypot(pt2[0] - pt[0], pt2[1] - pt[1])

                # Update IDs position
                if distance < 20:
                    tracking_objects[object_id] = pt
                    object_exists = True
                    if pt in center_points_cur_frame:
                        center_points_cur_frame.remove(pt)
                    continue

            # Remove IDs lost
            if not object_exists:
                tracking_objects.pop(object_id)

        # Add new IDs found
        for pt in center_points_cur_frame:
            tracking_objects[track_id] = pt
            track_id += 1

    #Check if a car passed the sector line
    for object_id, pt in tracking_objects.items():        
        if 430 < pt[1] < 460 :
            prev_point = tracking_objects_copy[object_id]
            if not 430 < prev_point[1] < 460 :
                millis = getTime(start)
                #print("CAR", object_id, ":", millis)
                print()
                print("Start Detecting color...")
                car = detect(frame, pt, 8)
                print("CAR: ", car, "passed in ", millis, " milliseconds")
                print()
                print()
                send_measurify(millis, car)
                



    cv2.imshow("Frame", frame)

    # Make a copy of the points
    center_points_prev_frame = center_points_cur_frame.copy()

    key = cv2.waitKey(1)
    
    if key == 27:
        break

cap.release()
cv2.destroyAllWindows()



