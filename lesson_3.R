##mahagadorn
##LessonThree
##ProgrammingCourse
##October 26, 2016

#Classes and objects-orientation

#3.1
#'object orientation' is the use of classes to help simplify programming
#continuously reread the first paragraph--relates it back to a great example (chairs)
#O-O programmers give every VARIABLE(object) a CLASS
#they write FUNCTIONS--methods-- that can be applied to these SPECIFIC CLASSES 
#Grouping things like this helps programmers save time and effort
#Ex. programmer writes a function that plots some data...this function can include seperate METHODS for when users calls that
#'...function with a data frame vs a matrix
#this lets R figure out what function to call on behalf of user
#NOTE: we will be using implementation S3 for our work
#in S3 we write METHODS for a particular CLASS (METHOD is a FUN that applies only to a particular CLASS) but we have no way to
#...specify what PROPERTIES(slot---for chairs weight or height) a particular CLASS should have



#3.2.1 Dexter is an instance of a Dog
#here we are going to walk through an example of how to make a dog CLASS
#also write methods for the dog CLASS
#and learn to hierarchically nest CLASSES (ie--inheritance; a dog is a mammal)


#in R CLASSES don't have a formal definition...but we can make an object of a certain CLASS 
#example

dexter <- list(length=60, weight=40, breed="mongrel") #save the list as dexter
class(dexter) <- "dog"  #this line is all we need to make dexter a class 

class(dexter) #[1] "list"

#note that there is no way to specify what slots (properties) an object of CLASS (here dog) should contain
#always best to write out what slots(properties) a CLASS should have


#OR write a function make.class or new.class function that will make dog with weight and breed slots
#see the following

new.dog <- function(weight,breed){  #weight and breed, here arguments, but they are the slots
  output <- list(weight=weight, breed=breed)  #output we want is a list containing weight and breed as
  class(output) <- "dog"  #we can classify the output as dog
  return(dog)   #return dog
}

class(new.dog)  #[1] "function"

#this function above is called a constructor

#3.2.2 CLASS METHODS
#'a METHOD is just a function
#'its a function that we associate with a particular CLASS
#'When writing a METHOD for a particular CLASS, you need to make sure the user has provided you with the right class if the first place

#'For Example

race <- function(first, second) {        #race is a function with the arguments first and second
  if(!inherits(first, "dog") | !inherits(second, "dog"))        #inherits purpose see below; saying first dog OR second dog
    stop("You haven't given me two dogs!")
  if(first$weight < second$weight){
    print("First dog won!")
    return(first)
  }
  print("Second dog won!")
  return(second)
}

class(race) #[1] "function"

#inherits indicates whether its first argument inherits from any other classes specied in the WHAT argment
    #if WHICH is true then an integer vector of the same legnth as WHAT is returned
    #each element indicates the position in class(x) matched by the element of WHAT
    #zero indicates no matches found
    #if WHICH is FALSE then TRUE is returned by inherits if any of the names in what match any CLASS

#reminder operator | AND & are logical operators
    #|= indicate logical OR   for example x|y means x OR y
    #& = indicates logical AND  for example x&y means x AND y





#3.2.3 Generic functions
#generic functions are extremely valuable
#these types of functions take essentially any kind of OBJECT, then dispatch that OBJECT(variable) to the 
#...correct METHOD (FUN) once they have identified the correct CLASS

#see they example below
#print is a generic function
#this is why it can take multiple types of OBJECTS (numeric, character, and data.frame) and succesfully print them

print
#function (x, ...)    the ... you already know but reminder--it means lots of other arguments are possible even w/o specification
#UseMethod("print")   
# <bytecode: 0x10b26b630>   this just means this is a 'compiled' function-->its underlying R code has been translated to machine code so it runs faster
# <environment: namespace:base>    means the function is defined in base R package

#lets try to define a method for dog
#first try to print dog

dog     #Error: object 'dog' not found
print(dog)     #Error in print(dog) : object 'dog' not found

#error message; let's fix this

print.dog <- function(x,...) {
  cat("This ", x$breed, "weighs ", x$weight, "kg/n")  #notice how we are putting in words and things to call
}

print.dog
# function(x, ...){
 # cat("This ", x$breed, "weighs ", x$weight, "kg\n")
# }


#we can also loop through the arguments
print.dog <- function(x,...){
  if(verbose==TRUE){
    cat("This ", x$breed, "weighs ", x$weight, "kg\n")
  } else cat("Woof!\n")
} 

print.dog

# function(x,...){
#   if(verbose==TRUE){
#     cat("This ", x$breed, "weighs ", x$weight, "kg\n")
#   } else cat("Woof!\n")
# }

#reminder--cat() simply means it produces output of an object, concatenates the representation
#converts arguments to character vectors, conccatenates them into a single characte vector and appends the give strings


###Now its time to write our own generic functions
#not looking forward to this
# as the lovely Panders used to tell you...keep calm and program on...and then I cry :)

ask.dog <- function(x) UseMethod("askdog")      #new generic function called ask.dog
askdog.default <- function(x) return("Woof! No-idea! Woof")    #fall through default
askdog.numeric <- function(x) return("Woof! A number! Woof")   #method for class numeric
askdog.dog <- function(x) return("Woof! A friend Woof!")       #method for class  ?

Fun3 <- function(x) return(3)
#this is a boring function but it still works
#returns three regardless of what x is hahaha...which i guess is the point

#tinker around a bit with this later


#3.2.4 Multiple Inheritance
#sometimes objects can be of more than one CLASS
#multiple inheritances lets us recognise this

#back to our old friend dexter

dexter <- list(lenght = 60, weight = 40, breed ="mongrel")  #defining dexter as a list
class(dexter) <- c("dog", "mammal")   #dexter is a class--> dog and mammal
brain <- list(length = 30, weight = 40) #now we have our friend brian
class(brain) <- c("mongoose", "mammal")  #brian is a mongoose but that is also a mammal
print.mammal <- function(x,...) cat("What a great mammal !\n") #print it

print.mammal(dexter)
print.mammal(dexter, brian)



################################################
## Exercises ###################################
################################################

#1) Implement a cat class, complete with race and print methods.
#First step: write a function that will make cat a class
new.cat <- function(color, weight, breed){       #these are the slots
  output <- list(color=color, weight=weight, breed=breed)  #saying we want the output to be a list
  class(output) <- "cat"  #for this our output is going to be the specific cat (incidence of class cat)
  return(output)    #return just gives us the output 
}

#here are our incidences
tonks <- new.cat(color = "EtBr Orange", weight = 40, breed = "mixed")  #opposite of usual. need cat name first <- new.cat
darwin <- new.cat(color = "Gray", weight = 50, breed = "tuxedo")

#write a function for race
race.fun <- function(first, second){      #first and second are cat names (object names)
  if(!inherits(first, "cat") | !inherits(second, "cat"))    
    stop("You haven't given me two cats!")
  if(first$weight < second$weight){
    print("First cat won!")
    return(first)
  }
  print("Second cat won!")
  return(second)
}

race.fun(tonks, darwin) #tonks is first cat here....she is lighter; therefore, she should win the race...the lighter cat wins the race
race.fun(darwin, tonks) #switch it up so that the plump cat is first, to making sure all is working well

#PrintFunction
print.cat <- function(x){
  cat("This", x$color, "colored cat weighs", x$weight, "lbs.", "Good things it's a", x$breed, "breed, people like that kind of cat!\n")
}
print.cat(tonks)






#2) Implement a point class that holds x and y information for a point in space.
#function
new.point <- function(x, y){
  output <- list(x=x, y=y)
  class(output) <- "point"
  return(output)
}

#print.function
print.point <- function(x){
  cat("For this point, x = ",x$x,"and y = ",x$y,", are the coordinates.\n")
}

#define a bunch of points
point1 <- new.point(1,5)
point2 <- new.point(6,8)
point3 <- new.point(4,6)
point4 <- new.point(10,2)
point5 <- new.point(6,2)
point6 <- new.point(11,0)


print.point(point1)
print.point(point2)

#point method

plot.point <- function(point, first=TRUE){
  if(first)
    plot(NA, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y")
  plot(point$x, point$y, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y")
}

plot.point(point1)


#3) Write a distance method that calculates the distance between two points in space. 

#method
dist.method <- function(point1, point2){
  if(!inherits(point1, 'point') | !inherits(point2, 'point'))
    stop(noquote("WARNING: You have not given me two points to work with!!!"))
  xSQ <- (point2$x - point1$x)^2
  ySQ <- (point2$y - point1$y)^2
  Dist <- round(sqrt(xSQ+ySQ), digits=1)
  if(Dist !=0){
    return(Dist)
  } 
  print(noquote("Warning: Distance between two points was zero. You should really look into this!\n"))
  return(Dist)
}

dist.method(point1, point2)

#Looks like this works (AND THE CROWD GOES WILD)

#I do not want this to be uncommented, but make it know I tried this to see if the return would print out right and it looks like it does.
#pointA <- new.point(1, 9)
#pointB <- new.point(1, 9)
#dist.method(pointA, pointB)
# [1] "Warning: Distance between two points was zero. You should really look into this!\n"
# [1] 0




#4 Implement a line class that takes two point objects and makes a line between them.

#we already have a point class(so we can use this to make our points "points")???
#no make new

#Make the class
new.line <- function(point1, point2){
  if(!inherits(point1, 'point') | !inherits(point2, 'point')) {
    stop(noquote("Something is not right, recheck your classes!!!"))
  }
  output <- list(point1=point1, point2=point2)
  class(output) <- "line"
  return(output)
}

#define a bunch of lines
Line1 <- new.line(point1, point2)
Line2 <- new.line(point1, point3)
Line3 <- new.line(point2, point3)
Line4 <- new.line(point4, point5)  #plotted
Line5 <- new.line(point4, point6)
Line6 <- new.line(point5, point6)

#method for plotting the line 
plot.line <- function(Line, first=TRUE){
  if(first)
    plot(NA, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y")
  segments(Line$point1$x, Line$point1$y, Line$point2$x, Line$point2$y)
}

#apply the function to object
plot.line(Line1)
plot.line(Line2)

print.line <- function(line){
  cat("For this line, x1 = ",point1$x,", y1 = ",point1$y, "and x2 = ", point2$x, ", y2 = ", point2$y)
}

print.line(Line1)

#5 Implement a polygon class that stores a polygon from point objects. Hint: a polygon is really just a
#  load of lines.

new.polygon <- function(point1, point2, point3, point4){
  if(!inherits(point1, 'point') | !inherits(point2, 'point') | !inherits(point3, 'point') | !inherits(point4, 'point')) {
    stop(noquote("Something is not right, recheck your classes!!!"))
  }
  output <- list(point1=point1, point2=point2, point3=point3, point4=point4)
  class(output) <- "polygon"
  return(output)
}

#store some points into object polygon
polygon1 <- new.polygon(point1, point2, point3, point4)
polygon2 <- new.polygon(point3, point4, point5, point6)



#method for plotting the polygon FROM POINTS!!!!!!
plot.polygon <- function(point1,point2,point3, point4, first=TRUE){
  if(first)
    plot(NA, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y")
      segments(point1$x, point1$y, point2$x, point2$y)
      segments(point2$x, point2$y, point3$x, point3$y)
      segments(point3$x, point3$y, point4$x, point4$y)
      segments(point4$x, point4$y, point1$x, point1$y)
} 

#plot with some pre-defined points
plot.polygon(point1, point2, point3, point4)
plot.polygon(point4, point2, point5, point6)

#define 2 new points tp make sure the negative is working
neg.point1 <- new.point(-15,-10)
neg.pount2 <- new.point(15, 15)

#apply function to points
plot.polygon(neg.point1, neg.pount2, point4, point6)


#6 Write plot methods for point and line objects.

#I think I already did this above so copy paste

#method for plotting a point; also can see above (Q2)
plot.point <- function(point, first=TRUE){
  if(first)
    plot(NA, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y")
  plot(point$x, point$y, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y")
}

#Test
plot.point(point1)

#pring methods...already above (Q2)
print.point <- function(x){
  cat("For this point, x = ",x$x,"and y = ",x$y,", are the coordinates.\n")
}


#method for plotting the line 
plot.line <- function(Line, first=TRUE){
  if(first)
    plot(NA, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y")
  segments(Line$point1$x, Line$point1$y, Line$point2$x, Line$point2$y)
}

#Testing this out on some lines
plot.line(Line1)
plot.line(Line2)


#print method for plot.line (Also See above)
print.line <- function(line){
  cat("For this line, x1 = ",point1$x,", y1 = ",point1$y, "and x2 = ", point2$x, ", y2 = ", point2$y)
}


# 7. Write a plot method for a polygon. Hint: if this isn’t trivial, you’re doing something wrong.

#method for plotting the polygon FROM POINTS!!!!!!
plot.polygon <- function(point1, point2, point3, point4, first=TRUE){
  if(first)
    plot(NA, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y")
  segments(point1$x, point1$y, point2$x, point2$y)
  segments(point2$x, point2$y, point3$x, point3$y)
  segments(point3$x, point3$y, point4$x, point4$y)
  segments(point4$x, point4$y, point1$x, point1$y)
} 

plot.polygon(point1, point2, point3, point4)
plot.polygon(point4, point2, point5, point6)
#test to make sure it can go negative
neg.point1 <- new.point(-15,-10)
neg.pount2 <- new.point(15, 15)
plot.polygon(neg.point1, neg.pount2, point4, point6)


#8  Create a canvas object that the add function can add point, line, circle, and polygon objects to.
#   Write plot and print methods for this class.


#so I need to create a canvas object...what is a canvas object?
#something that means it will be overarching? cover multiple things?

#what do all these objects have in common?
#they all have some sort of coordinates...but what a bout the circle. how does that work?
#just try and we will see what we need to alter later

#so all these have coordinates in common, i.e. (x,y), just like points
#remember an object is nothing but a variable and in our case we want this variable to have a class.

#I wrote this canvas function thinking about it as all of our canvas objects have an x,y in common
#with just an x and y we can generate a point, a line, and lines of a polygon
#the only extra tidbit needed would be for a circle where we need to include something such as a radius...so I put in the ...
# the ... gives us the freedom to add additional arguments to our class objects

#Need to write circle class (because we need this to go into canvas object:



##
#function for making a new circle class
new.circle <- function(point, radius){
  output <- list(point=point, radius=radius)
  class(output) <- "circle"
  return(output)
}



  
#circle method:
#equations to keep in mind:     x=radius*cos(circumference); y=r*sin(circumference)
#these equations will have x,y as the coordinates of any point on the circle
#circumference of the circle is what we want to be plotting so how do we calculate that????
#circumference is nothing but the path that surrounds the circle
#can't we just generate a whole bunch of close values that move up in really really small incriments
    #english version--- we need to multiply something by pi at least
    #circumference equation is 2 * pi * r
      #translate to code???? 2*(circle$radius * pi)
      #seq can be used to generate a sequences of numbers based on a criteria
      #we want to start the sequence off at zero I think, we can try it and adjust if needed
      # sooooo, seq(0, 2*(circle$radius *pi), length=some BIG number)
    #the rest is fill in the blank...i think

##############This circle function workds but it only plots it at the origin 0,0
# plot.circle <- function(circle){
#   circum <- seq(0, 2*(circle$radius * pi), length=10000)
#   ycor <- rbind(sin(circum) * circle$radius)             #center of the circle is our point! so subset
#   xcor <- (circle$radius *  cos(circum))
#   plot(NA, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y", type="l")
#   lines(xcor, ycor)
# } 

#so the above didn't move us away from the origin.....so lets add in the x and y coordinates so that it moves to that location



#plottng method for the circle
plot.circle <- function(circle, first=TRUE){
  circum <- seq(0, 2*(circle$radius * pi), length=10000)
  ycor <- rbind((sin(circum) * circle$radius) + circle$point$x)             
  xcor <- ((circle$radius *  cos(circum)) + circle$point$y)  
  if(first)
    plot(NA, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y")
    lines(xcor, ycor)
} 

#make circles
circle1 <- new.circle(point1, radius=2) 
circle2 <- new.circle(point3, radius=3)



#envoke method
plot.circle(circle1)
plot.circle(circle2)




#now that we have made the cirle we can include it in the canvas object
#canvas class
new.canvas <- function(point, line, circle, polygon){
  if(!inherits(point, 'point')) {
    stop(noquote("Point input not of point class!"))
  }
  if(!inherits(line, 'line')) {
    stop(noquote("Line input not of line class!"))
  }
  if(!inherits(circle, 'circle')) {
    stop(noquote("polygon input not of polygon class!"))
  }
  if(!inherits(polygon, 'polygon')) {
    stop(noquote("polygon input not of polygon class!"))
  }
  output <- list(point=point, line=line, circle=circle, polygon=polygon)
  class(output) <- "canvas.object"
  return(output)
}


#making canvas object
canvas1 <- new.canvas(point3, Line4, circle2, polygon2)



#print.function
print.canvas <- function(object){
    cat("This object is a of class canvas!")
    return(object)
}

#test print
print.canvas(canvas1)


#plot function
plot.canvas <- function(point, line, circle, polygon, first=TRUE){
  if(first)
  plot(NA, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y", type="l")
    point=plot.point(point, first=FALSE)
    lines=plot.line(line, first=FALSE)
    lines=plot.circle(circle, first=FALSE)
    line=plot.polygon(point1=polygon$point1, point2=polygon$point2, point3=polygon$point3, point4=polygon$point4,first=FALSE)
}

#already defined but putting here for ease
polygon2 <- new.polygon(point3, point4, point5, point6)

#making new point that isnt associated with other objects in the canvas
pointYAY <- new.point(-15, 0)

#plotting the canvas
plot.canvas(pointYAY, Line6, circle1, polygon1)






##9 Implement a circle object that takes a point and a radius and stores a circle. Don’t make a circle out
#of lines!

#generated this in question 8....See text above for details on how it was generated

plot.circle <- function(circle, first=TRUE){
  circum <- seq(0, 2*(circle$radius * pi), length=10000)
  ycor <- rbind((sin(circum) * circle$radius) + circle$point$x)             
  xcor <- ((circle$radius *  cos(circum)) + circle$point$y)  
  if(first)
    plot(NA, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y")
  lines(xcor, ycor)
} 

#make circles
circle1 <- new.circle(point1, radius=2) 
circle2 <- new.circle(point3, radius=3)



#envoke method
plot.circle(circle1)
plot.circle(circle2)




#10 Write area generic methods for circle and polygon objects.

#Oh, crap I figured this out!!!!! OMG! I just danced around my lab...It's the small victories

#defining a generic method

area <- function(x, ...) UseMethod('area', x)
area.circle <- function(x, ...) return(((x$radius)^(2)) * pi)
area.polygon <- function(x, ...) return((dist.method(x$point1, x$point2))^2)      #this is specifically for a square, got Will's approval to do any polygon
area.default <- function(x, ...) return("Sorry, can't calulate the area!")
 

#assign circle class!
circle1 <- new.circle(point1, radius=2) 
circle2 <- new.circle(point3, radius=3)

#defining the coordinates of the shape 
Sq1 <- new.point(0,0)
Sq2 <- new.point(0,4)
Sq3 <- new.point(4,4)
Sq4 <- new.point(4,0)

#assign class & plot
square <- new.polygon(Sq1, Sq2, Sq3, Sq4)
plot.polygon(Sq1, Sq2, Sq3, Sq4)


#test it out
area(circle1)
area(circle2)
area(square)
area(Line1)

# > area(circle1)
# [1] 12.56637
# > area(circle2)
# [1] 28.27433
# > area(square)
# [1] 16
# > area(Line1)
# [1] "Sorry, can't calulate the area"

  



#11 Add support for circle objects to your canvas.

#This was already done in Question 8 with my original canvas!
########################
#####Will you told me to copy and paste my original canvas here so I have, but it is exactly the same as question 8


#canvas class containing all requested objects
new.canvas <- function(point, line, circle, polygon){
  if(!inherits(point, 'point')) {
    stop(noquote("Point input not of point class!"))
  }
  if(!inherits(line, 'line')) {
    stop(noquote("Line input not of line class!"))
  }
  if(!inherits(circle, 'circle')) {
    stop(noquote("polygon input not of polygon class!"))
  }
  if(!inherits(polygon, 'polygon')) {
    stop(noquote("polygon input not of polygon class!"))
  }
  output <- list(point=point, line=line, circle=circle, polygon=polygon)
  class(output) <- "canvas.object"
  return(output)
}


#making canvas object
canvas1 <- new.canvas(point3, Line4, circle2, polygon2)



#print.function
print.canvas <- function(object){
  cat("This object is a of class canvas!")
  return(object)
}

#test print
print.canvas(canvas1)


#plot function
plot.canvas <- function(point, line, circle, polygon, first=TRUE){
  if(first)
    plot(NA, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y", type="l")
  point=plot.point(point, first=FALSE)
  lines=plot.line(line, first=FALSE)
  lines=plot.circle(circle, first=FALSE)
  line=plot.polygon(point1=polygon$point1, point2=polygon$point2, point3=polygon$point3, point4=polygon$point4,first=FALSE)
}

#already defined but putting here for ease
polygon2 <- new.polygon(point3, point4, point5, point6)

#making new point that isnt associated with other objects in the canvas
pointYAY <- new.point(-15, 0)

#plotting the canvas
plot.canvas(pointYAY, Line6, circle1, polygon1)





#12 ??? May come back to



#13 This way isnt working!!!!
plot.canvas.col <- function(point, line, circle, polygon, first=TRUE, par){
  if(first)
    plot(NA, xlim=c(-20, 20), ylim=c(-20, 20), xlab="x", ylab="y", type="l")
  point=plot.point(point, first=FALSE, col=color[1])
  lines=plot.line(line, first=FALSE, col=color[2])
  lines=plot.circle(circle, first=FALSE, col=color[3])
  line=plot.polygon(point1=polygon$point1, point2=polygon$point2, point3=polygon$point3, point4=polygon$point4, first=FALSE, col=color[4])
}

plot.canvas.col(pointYAY, Line6, circle1, polygon1)

color=c("blue", "red", "orange", "purple")

