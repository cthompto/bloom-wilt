-- Bloom and Wilt
-- Chelsea Thompto

require("L5")

myPixels = {}

function setup()
    size(600, 900)
    angleMode(DEGREES)
    rectMode(CENTER)
    noStroke()
    windowTitle("Bloom / Wilt")

    -- Describe the visual output
    describe('Modifies a pixelated nature scene over time.')

    imgTitle = {"flowers","maple-leaf","pink-rose","red-leaf","snake"}
    --img = loadImage('assets/red-leaf-600-900.jpg')
    img = loadImage('assets/'..random(imgTitle)..'-600-900.jpg')
    image(img, 0, 0, width, height)

    font = loadFont('assets/PixelifySans-Regular.ttf')
    textFont(font)
    textAlign(CENTER)
    textSize(100)

    step = "intro"
    frameTarget = 0
    frameInt = 1800
    forward = true

    pixelSize = 10
    limit = ((width / pixelSize) * (height / pixelSize))
    x = pixelSize / 2
    y = pixelSize / 2

    -- generate pixel field
    pixelGeneration()

    spotInit()
end

function draw()
    background(0, 0, 0, 5)
    if step == "intro" then
      image(img, 0, 0, width, height)
      staticPixel()
      overlayGraphic()
    elseif step == "main" then
      pixelProcess()
      spotMove()
      slideEvent()
    end
end

function keyPressed() 
  if key == 'return' then
    if step == "intro" then
      step = "main"
    elseif step =="main" then
      step = "intro"
    end
    frameTarget = frameCount+frameInt
  elseif key == 'space' then
    save('bloom-wilt.png')
  end
end

function overlayGraphic()
  fill(255,255,255,200)
  rect(width/2, height/2, 400, 700,10)
  fill(0)
  textAlign(CENTER)
  textSize(100)
  text("Bloom", 300,200)
  text("/", 300,300)
  text("Wilt", 300,400)
  textSize(40)
  text("By:", 300, 500)
  text("Chelsea Thompto", 300, 550)
  textSize(20)
  textAlign(LEFT)
  text("Instructions:\nPress enter to start, the work will run continuously. Restart the program to pick a new image.", 120, 600, 360)
  textSize(15)
  text("Credits:\nMade with L5 (Processing for Lua).\nTitle screen font is Pixelify Sans", 120, 725, 360)
end

function slideEvent()
  if frameCount >= frameTarget and frameCount < frameTarget+100 then
    if frameCount%5 == 0 then
      if forward then
        pixelXslide1()
      else
        pixelXslide2()
      end
    end
  elseif frameCount >= frameTarget+5 and frameCount < frameTarget+200 then
    if frameCount%5 == 0 then
      if forward then
        pixelYslide1()
      else
        pixelYslide2()
      end
    end
  elseif frameCount > frameTarget+200 then
    frameTarget = frameCount+frameInt+200
    if forward then
      forward = false
    elseif not forward then
      forward = true
    end
  end
end

function pixelXslide1()
  for i = 1, #myPixels do
    if myPixels[i].iy == 5 or (myPixels[i].iy+5)%20 == 0 then
      myPixels[i].x = myPixels[i].x + 0.25
    else 
      myPixels[i].x = myPixels[i].x - 0.25
    end
  end
end

function pixelYslide1()
  for i = 1, #myPixels do
    if myPixels[i].ix == 5 or (myPixels[i].ix+5)%20 == 0 then
      myPixels[i].y = myPixels[i].y + 0.25
    else 
      myPixels[i].y = myPixels[i].y - 0.25
    end
  end
end

function pixelXslide2()
  for i = 1, #myPixels do
    if myPixels[i].iy == 5 or (myPixels[i].iy+5)%20 == 0 then
      myPixels[i].x = myPixels[i].x - 0.25
    else 
      myPixels[i].x = myPixels[i].x + 0.25
    end
  end
end

function pixelYslide2()
  for i = 1, #myPixels do
    if myPixels[i].ix == 5 or (myPixels[i].ix+5)%20 == 0 then
      myPixels[i].y = myPixels[i].y - 0.25
    else 
      myPixels[i].y = myPixels[i].y + 0.25
    end
  end
end

function pixelQuake() 
  for i = 1, #myPixels do
    shiftX = random(-5,5)
    shiftY = random(-5,5)
    myPixels[i].x = myPixels[i].x + shiftX
    myPixels[i].y = myPixels[i].y + shiftY
    myPixels[i].r = myPixels[i].r + random(-5,5)
  end
end

function staticPixel()
  for i = 1, #myPixels do
    push()
    translate(myPixels[i].x, myPixels[i].y)
    rotate(myPixels[i].r)
    fill(myPixels[i].color[1],myPixels[i].color[2],myPixels[i].color[3],100)
    rect(0, 0, myPixels[i].s, myPixels[i].s)
    pop()
  end
end

function pixelGeneration()
    for i = 1, limit do
        g = get(x, y)
        print(g)
        newPixel = {
            color = g,
            x = x,
            y = y,
            ix = x,
            iy = y,
            r = 0,
            s = pixelSize
        }
        table.insert(myPixels, newPixel)
        y = y + pixelSize;
        if y == height + (pixelSize / 2) then
            y = pixelSize / 2;
            x = x + pixelSize;
        end
    end
end

function pixelProcess()
    for i = 1, #myPixels do
        if (spotX - myPixels[i].x) * (spotX - myPixels[i].x) + (spotY - myPixels[i].y) * (spotY - myPixels[i].y) <= 180 * 180 then
            myPixels[i].r = myPixels[i].r + 1
            myPixels[i].s = myPixels[i].s + 0.01
        end
        if (spot2X - myPixels[i].x) * (spot2X - myPixels[i].x) + (spot2Y - myPixels[i].y) * (spot2Y - myPixels[i].y) <= 180 * 180 then
            myPixels[i].r = myPixels[i].r - 1
            myPixels[i].s = myPixels[i].s - 0.01
        end
        push()
        translate(myPixels[i].x, myPixels[i].y)
        rotate(myPixels[i].r)
        --scale(myPixels[i].s)
        fill(myPixels[i].color)
        --rect(0,0, pixelSize, pixelSize)
        rect(0, 0, myPixels[i].s, myPixels[i].s)
        pop()
    end
end

function spotInit()
    spotX = 200
    spotY = 200
    intXD = random({1,-1})
    moveX = random(1,2)*intXD
    intYD = random({1,-1})
    moveY = random(1,2)*intYD

    
    spot2X = 200
    spot2Y = 400
    int2XD = random({1,-1})
    move2X = random(1, 2)*int2XD
    int2YD = random({1,-1})
    move2Y = random(1, 2)*int2YD
end

function spotMove()
    spotX = spotX + moveX
    spotY = spotY + moveY

    if spotX <= 0 then
        moveX = random(1, 2)
    elseif spotX >= width then
        moveX = random(-1, -2)
    end

    if spotY <= 0 then
        moveY = random(1, 2)
    elseif spotY >= height then
        moveY = random(-1, -2)
    end

    spot2X = spot2X + move2X
    spot2Y = spot2Y + move2Y

    if spot2X <= 0 then
        move2X = random(1, 2)
    elseif spot2X >= width then
        move2X = random(-1, -2)
    end

    if spot2Y <= 0 then
        move2Y = random(1, 2)
    elseif spot2Y >= height then
        move2Y = random(-1, -2)
    end
end
