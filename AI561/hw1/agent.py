# CSCI 561 USC Fall 2013
# Homework 1 Part 2 Problem 1
# Skeleton Code Written by Toy Leksut 08/30/13
# Assignment Done by [Student's name here]

import Myro
from Myro import *
from Graphics import *
import math


width, height = 510, 300
sim = Simulation("Parking Structure", width, height, Color("lightgrey"))
sim = Simulation("Parking Structure", width, height, Color("lightgrey"))

# Add walls
wallLength = 100
for i in xrange(10, 510, 120):
    sim.addWall((i, 10), (i+10, 10+wallLength), Color("black"))
    sim.addWall((i, 200), (i+10, 200+wallLength), Color("black"))

# Add boundaries
sim.addWall((0, 0), (width, 10), Color("blue"))
sim.addWall((0, 0), (10, height), Color("blue"))
sim.addWall((width - 10, 0), (width, height), Color("blue"))
sim.addWall((0, height - 10), (width, height), Color("blue"))

# Add Goal
sim.addWall((30, 30), (120, 40), Color("red"))

# Set up simulation
sim.setup()
robot = makeRobot("SimScribbler", sim)
robot.setPose(426, 70, 67)


# +++++++++++++++++++++++++++++++++++++++++
# ----------      AGENTS       ------------
# +++++++++++++++++++++++++++++++++++++++++

class Agent(object):
    def useJoystick(self):
        return False
    def act(self, pic):
        return False

class UserControlAgent(Agent):
    def useJoystick(self):
        return True
    def act(self, pic):
        #print(getBlue(getPixel(pic, getWidth(pic)/2, getHeight(pic)/2)))
        #print(robot.getLocation())
        a=robot.getLocation()
        print(a[0])
        #print("X",getX(getPixel(pic, getWidth(pic)/2, getHeight(pic)/2)))
        #print("Y",getY(getPixel(pic, getWidth(pic)/2, getHeight(pic)/2)))
        pix = getRed(getPixel(pic, getWidth(pic)/2, getHeight(pic)/2))
        if pix > 0:
            robot.translate(1)

class SimpleReflexAgent(Agent):
    def act(self, pic):
        # Only cares about red pixel in the center of the image
        pix = getRed(getPixel(pic, getWidth(pic)/2, getHeight(pic)/2))
        if pix > 0:
            robot.translate(1)
        else:
            robot.backward(1, randomNumber())
            robot.turnLeft(2, 1+randomNumber())
            robot.forward(1, 2+randomNumber())
        return False


# To do:
# Implement all the agents (Model-based, Utility-based, Goal-based)
#l=Rectangle(Point(10,150),Point(500,151))
#sim.addShape(l)
# Agent 1: Model-based
def getDist():
    global count
    count=1
    targetx=57.393
    targety=65.982
    l=robot.getLocation()
    actual_dist=math.sqrt(math.fabs(l[0]-targetx)*math.fabs(l[0]-targetx)+math.fabs(l[1]-targety)*math.fabs(l[1]-targety)) #distance formula
    if actual_dist>1:
        print("Robot is",actual_dist,"units away from the goal")
    else:
        print("Goal Reached. Success!!")
    setLEDBack(1)


class UtilityBasedAgent(Agent):


    def act(self, pic):
        flag=False
        loc=robot.getLocation() #returns x,y of robot in list form
        if getRed(getPixel(pic, getWidth(pic)/2, getHeight(pic)/2))>230:
            print(getRed(getPixel(pic, getWidth(pic)/2, getHeight(pic)/2)))
            robot.translate(1)
            getDist()
            flag=True
            loc=robot.getLocation()
            print(loc)
        else:
            #setLEDBack(0.5)
            if loc[1] <= height/2+50 and loc[1] >= height/2-40 and loc[0] >= 110 and flag==False: #if at the center of the path
                #print("inside lane")
                flag=True
                #print(getKeyPressed())
                print(loc)
                #print(robot.getAngle())
                robot.setAngle(180)
                while loc[0]>=70:
                    robot.translate(1)
                    getDist()
                    loc=robot.getLocation()
                    #print(loc,"inside lane")
                robot.setAngle(-90)
                #robot.translate(1)
                loc=robot.getLocation()
            if loc[1] >= height/2+50 and flag==False:
                #print("inside down")
                robot.setAngle(-90)
                loc=robot.getLocation()
                while loc[0]>=70 and loc[1]>=height/2+20:
                    #robot.translate(1)
                    #print("while")
                    robot.move(1,0)
                    getDist()
                    loc=robot.getLocation()
                    #print(loc,"down")
                loc=robot.getLocation()
            elif loc[1] < height/2-40 and flag==False:
                #print("inside up")
                robot.setAngle(90)
                loc=robot.getLocation()
                while loc[0]>=70 and loc[1]<=height/2-20:
                    robot.translate(1)
                    getDist()
                    loc=robot.getLocation()
                    #print(loc,"up")
                loc=robot.getLocation()
            else:
                robot.setAngle(-90)
                robot.translate(1)
                getDist()
                loc=robot.getLocation()










# Agent 2: Utility-based
class ModelBasedAgent(Agent):
    def act(self, pic):
        #raise Exception("Not implemented") # Remove this and add your code below
        model={ "box1/6x":140,
               "topy":110, #y is common for all boxes 1/2/3
               "box2/5x":260,
               "box3/4x":380,
               "downy":200} #y is common for all boxes 4/5/6}
        loc=robot.getLocation()
        print(loc)
        if getRed(getPixel(pic, getWidth(pic)/2, getHeight(pic)/2))>0:
            robot.translate(1)
        else:
               if loc[0] >= model["box1/6x"] and loc[1] <= model["topy"] and loc[0] <=model["box2/5x"]:
                    print(loc,"1")
                    robot.setAngle(90)
                    loc=robot.getLocation()
                    while loc[1] <= model["topy"]+10:#box 1
                        robot.translate(1)
                        loc=robot.getLocation()
                    robot.setAngle(180)
                    while loc[0] <= model["box1/6x"]-75:
                        robot.translate(1)
                        loc=robot.getLocation()
                    robot.setAngle(-90)
               elif loc[0] >= model["box2/5x"] and loc[1] <= model["topy"] and loc[0] <=model["box3/4x"]:
                    print(loc,"2")
                    robot.setAngle(90)
                    loc=robot.getLocation()#box 2
                    while loc[1] <= model["topy"]+10:
                        robot.translate(1)
                        loc=robot.getLocation()
                    robot.setAngle(180)
                    while loc[0] <= model["box1/6x"]-75:
                        robot.translate(1)
                        loc=robot.getLocation()
                    robot.setAngle(-90)
               elif loc[0] >= model["box3/4x"] and loc[1] <= model["topy"] and loc[0] <=width:
                    print(loc,"3")
                    robot.setAngle(90)
                    loc=robot.getLocation()
                    while loc[1] <= height/2:  #box 3
                        robot.translate(1)
                        loc=robot.getLocation()
                    robot.setAngle(180)
                    while loc[0] <= model["box1/6x"]-75:
                        robot.translate(1)
                        loc=robot.getLocation()
                    robot.setAngle(-90)
               elif loc[0] >= model["box3/4x"] and loc[1] >= model["downy"] and loc[0] <=width:
                    print(loc,"4")
                    robot.setAngle(-90)
                    loc=robot.getLocation()
                    while loc[1] >= height/2:
                        robot.translate(1)
                        loc=robot.getLocation()#box 4
                    robot.setAngle(180)
                    while loc[0] >= model["box1/6x"]-75:
                        robot.translate(1)
                        loc=robot.getLocation()
                    robot.setAngle(-90)
               elif loc[0] >= model["box2/5x"] and loc[1] >= model["downy"] and loc[0] <=model["box3/4x"]:
                    print(loc,"5")
                    print(robot.getAngle())
                    robot.setAngle(-90)
                    print(robot.getAngle())
                    loc=robot.getLocation()
                    while loc[1] >= height/2:
                        robot.translate(1)
                        loc=robot.getLocation()#box 5
                    robot.setAngle(180)
                    while loc[0] >= model["box1/6x"]-75:
                        robot.translate(1)
                        loc=robot.getLocation()
                        #break for testing lane part
                    robot.setAngle(-90)
               elif loc[0] >= model["box1/6x"] and loc[1] >= model["downy"] and loc[0] <=model["box2/5x"]:
                    print(loc,"6")
                    robot.setAngle(-90)
                    loc=robot.getLocation()
                    while loc[1] >= height/2:
                        robot.translate(1)
                        loc=robot.getLocation()
                    robot.setAngle(180)
                    while loc[0] >= model["box1/6x"]-75:#box 6
                        robot.translate(1)
                        loc=robot.getLocation()
                    robot.setAngle(-90)
               elif loc[0]>=model["box1/6x"]-10 and loc[1]>=model["topy"] and loc[1]<= model["downy"]:
                    print("i am in lane")
                    if height/2>loc[1]:
                        robot.setAngle(90)
                        while loc[1]<=height/2:
                            robot.translate(1)
                            loc=robot.getLocation()
                    loc=robot.getLocation()
                    if height/2<loc[1]:
                        robot.setAngle(-90)
                        while loc[1]>=height/2:
                            robot.translate(1)
                            loc=robot.getLocation()
                    loc=robot.getLocation()
                    robot.setAngle(180)
                    while loc[0] >= model["box1/6x"]-75:#lane...
                        robot.translate(1)
                        loc=robot.getLocation()
                    robot.setAngle(-90)
               else:
                    robot.setAngle(-90)



# Agent 3: Goal-based
class GoalBasedAgent(Agent):

    def act(self, pic):
        #raise Exception("Not implemented") # Remove this and add your code below
        loc=robot.getLocation() #returns x,y of robot in list form
        print(loc,"**********1")
        #flag=False;
        print(robot.getAngle(),"***********2")
        if getRed(getPixel(pic, getWidth(pic)/2, getHeight(pic)/2))>0:
            robot.translate(1)
        else:
            if loc[1] <= height/2+50 and loc[1] >= height/2-40 and loc[0] >= 110:# and flag==False: #if at the center of the path
                flag=True;
                print(loc)
                print(robot.getAngle())
                robot.setAngle(180)
                while loc[0]>=70:
                    robot.translate(1)
                    loc=robot.getLocation() #update location info for robot
                robot.setAngle(-90)
                #robot.translate(1)
                loc=robot.getLocation()
            if loc[1] >= height/2+50:# and flag==False:
                print("3****************")
                print(robot.getAngle())
                robot.setAngle(-90)
                loc=robot.getLocation()
                while loc[0]>=70 and loc[1]>=height/2+20:
                    robot.translate(1)
                    loc=robot.getLocation()
                    print(loc)
                loc=robot.getLocation()
            elif loc[1] < height/2-40:# and flag==False:
                print("*****************4")
                print(robot.getAngle())
                robot.setAngle(90)
                loc=robot.getLocation()
                while loc[0]>=70 and loc[1]<=height/2-20:
                    robot.translate(1)
                    loc=robot.getLocation()
                    print(loc)
                loc=robot.getLocation()
            else:
                robot.setAngle(-90)








# +++++++++++++++++++++++++++++++++++++++++

#agent = UserControlAgent()
#agent = SimpleReflexAgent()
#agent = ModelBasedAgent()
agent = UtilityBasedAgent()
#agent = GoalBasedAgent()

#if agent.useJoystick(): joystick()

while True:
    # Feed video stream to the agent
    pic = takePicture()
    show(pic)
    agent.act(pic)
