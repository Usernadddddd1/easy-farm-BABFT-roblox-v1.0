local player = game.Players.LocalPlayer

local flySpeed = 750

local function getCharacter()
    local char = player.Character
    if not char then
        char = player.CharacterAdded:Wait()
    end
    return char
end

local function teleport(rootPart, pos)
    if rootPart then
        rootPart.CFrame = CFrame.new(pos)
    end
end

local function flyTo(rootPart, targetPos, speed)
    if not rootPart then return end
    
    local startPos = rootPart.Position
    local distance = (targetPos - startPos).Magnitude
    local duration = distance / speed
    
    if duration <= 0 then return end
    
    local startTime = tick()
    local endTime = startTime + duration
    
    while tick() < endTime do
        if not rootPart or not rootPart.Parent then break end
        local alpha = (tick() - startTime) / duration
        local currentPos = startPos:Lerp(targetPos, alpha)
        rootPart.CFrame = CFrame.new(currentPos)
        task.wait()
    end
    
    if rootPart and rootPart.Parent then
        rootPart.CFrame = CFrame.new(targetPos)
    end
end

local function setGravity(humanoid, on)
    if not humanoid then return end
    
    if on then
        humanoid.PlatformStand = false
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
    else
        humanoid.PlatformStand = true
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
    end
end

local function setNoClip(char, enabled)
    if not char then return end
    
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not enabled
        end
    end
end

while true do
  
    local char = getCharacter()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    -- step 1
    setGravity(humanoid, false)
    
    -- step 2
    setNoClip(char, true)
    teleport(rootPart, Vector3.new(-69.02, 50.31, 644.43))
    task.wait(0.1)
    
    -- step 3
    flyTo(rootPart, Vector3.new(-41.79, 50.15, 8675.35), flySpeed)
    
    -- step 4
    flyTo(rootPart, Vector3.new(-55.88, -361.12, 9488.14), flySpeed)
    
    -- step 5
    setNoClip(char, false)
    setGravity(humanoid, true)
    
    -- step 6
    task.wait(15)
    
end
