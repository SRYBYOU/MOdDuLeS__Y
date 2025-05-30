-- مكتبة UI كاملة لـ Roblox
-- Complete Roblox UI Library

local UILibrary = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- الإعدادات الافتراضية
local DefaultSettings = {
    Theme = {
        Primary = Color3.fromRGB(64, 128, 255),
        Secondary = Color3.fromRGB(45, 45, 45),
        Background = Color3.fromRGB(30, 30, 30),
        Surface = Color3.fromRGB(40, 40, 40),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(180, 180, 180),
        Success = Color3.fromRGB(76, 175, 80),
        Warning = Color3.fromRGB(255, 193, 7),
        Error = Color3.fromRGB(244, 67, 54),
        Accent = Color3.fromRGB(255, 64, 129)
    },
    Animation = {
        Duration = 0.3,
        EasingStyle = Enum.EasingStyle.Quart,
        EasingDirection = Enum.EasingDirection.Out
    },
    UI = {
        CornerRadius = UDim.new(0, 8),
        Padding = UDim.new(0, 10),
        Spacing = UDim.new(0, 5)
    }
}

-- وظائف مساعدة
local function CreateTween(object, properties, duration)
    duration = duration or DefaultSettings.Animation.Duration
    local tweenInfo = TweenInfo.new(
        duration,
        DefaultSettings.Animation.EasingStyle,
        DefaultSettings.Animation.EasingDirection
    )
    return TweenService:Create(object, tweenInfo, properties)
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or DefaultSettings.UI.CornerRadius
    corner.Parent = parent
    return corner
end

local function CreatePadding(parent, padding)
    local pad = Instance.new("UIPadding")
    padding = padding or DefaultSettings.UI.Padding
    pad.PaddingTop = padding
    pad.PaddingBottom = padding
    pad.PaddingLeft = padding
    pad.PaddingRight = padding
    pad.Parent = parent
    return pad
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or DefaultSettings.Theme.Primary
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

-- إنشاء النافذة الرئيسية
function UILibrary:CreateWindow(title, config)
    config = config or {}
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "UILibrary_" .. title
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, config.Size and config.Size.X or 500, 0, config.Size and config.Size.Y or 400)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    MainFrame.BackgroundColor3 = DefaultSettings.Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    CreateCorner(MainFrame)
    CreateStroke(MainFrame, DefaultSettings.Theme.Primary, 2)
    
    -- شريط العنوان
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = DefaultSettings.Theme.Primary
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    CreateCorner(TitleBar, UDim.new(0, 8))
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -80, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = DefaultSettings.Theme.Text
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = TitleBar
    
    -- زر الإغلاق
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = DefaultSettings.Theme.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = DefaultSettings.Theme.Text
    CloseButton.TextSize = 18
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TitleBar
    
    CreateCorner(CloseButton, UDim.new(0, 4))
    
    -- زر التصغير
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
    MinimizeButton.BackgroundColor3 = DefaultSettings.Theme.Warning
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = DefaultSettings.Theme.Text
    MinimizeButton.TextSize = 16
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = TitleBar
    
    CreateCorner(MinimizeButton, UDim.new(0, 4))
    
    -- منطقة المحتوى
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Name = "Content"
    ContentFrame.Size = UDim2.new(1, 0, 1, -40)
    ContentFrame.Position = UDim2.new(0, 0, 0, 40)
    ContentFrame.BackgroundColor3 = DefaultSettings.Theme.Background
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 8
    ContentFrame.ScrollBarImageColor3 = DefaultSettings.Theme.Primary
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentFrame.Parent = MainFrame
    
    CreatePadding(ContentFrame)
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = DefaultSettings.UI.Spacing
    ContentLayout.Parent = ContentFrame
    
    -- متغيرات التحكم
    local isMinimized = false
    local isDragging = false
    local dragStart = nil
    local startPos = nil
    
    -- وظائف التحكم في النافذة
    local function UpdateCanvasSize()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
    end
    
    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)
    
    -- وظيفة السحب
    local function StartDrag(input)
        isDragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
    
    local function UpdateDrag(input)
        if isDragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end
    
    local function EndDrag()
        isDragging = false
    end
    
    -- أحداث السحب
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            StartDrag(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            UpdateDrag(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            EndDrag()
        end
    end)
    
    -- وظيفة التصغير
    local function ToggleMinimize()
        isMinimized = not isMinimized
        local targetSize = isMinimized and UDim2.new(0, 500, 0, 40) or UDim2.new(0, 500, 0, 400)
        CreateTween(MainFrame, {Size = targetSize}):Play()
    end
    
    MinimizeButton.MouseButton1Click:Connect(ToggleMinimize)
    
    -- وظيفة الإغلاق
    CloseButton.MouseButton1Click:Connect(function()
        CreateTween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
        wait(DefaultSettings.Animation.Duration)
        ScreenGui:Destroy()
    end)
    
    -- تأثيرات الأزرار
    local function AddButtonEffects(button)
        button.MouseEnter:Connect(function()
            CreateTween(button, {Size = button.Size + UDim2.new(0, 2, 0, 2)}):Play()
        end)
        
        button.MouseLeave:Connect(function()
            CreateTween(button, {Size = button.Size - UDim2.new(0, 2, 0, 2)}):Play()
        end)
    end
    
    AddButtonEffects(CloseButton)
    AddButtonEffects(MinimizeButton)
    
    -- كائن النافذة
    local Window = {
        Frame = MainFrame,
        Content = ContentFrame,
        ScreenGui = ScreenGui,
        Layout = ContentLayout
    }
    
    -- إضافة تبويب
    function Window:CreateTab(name)
        local Tab = {}
        
        local TabFrame = Instance.new("Frame")
        TabFrame.Name = name
        TabFrame.Size = UDim2.new(1, 0, 0, 0)
        TabFrame.BackgroundColor3 = DefaultSettings.Theme.Surface
        TabFrame.BorderSizePixel = 0
        TabFrame.Parent = ContentFrame
        
        CreateCorner(TabFrame)
        CreatePadding(TabFrame)
        
        local TabLayout = Instance.new("UIListLayout")
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = DefaultSettings.UI.Spacing
        TabLayout.Parent = TabFrame
        
        local TabTitle = Instance.new("TextLabel")
        TabTitle.Name = "Title"
        TabTitle.Size = UDim2.new(1, 0, 0, 30)
        TabTitle.BackgroundTransparency = 1
        TabTitle.Text = name
        TabTitle.TextColor3 = DefaultSettings.Theme.Primary
        TabTitle.TextSize = 18
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left
        TabTitle.Font = Enum.Font.GothamBold
        TabTitle.Parent = TabFrame
        
        local function UpdateTabSize()
            TabFrame.Size = UDim2.new(1, 0, 0, TabLayout.AbsoluteContentSize.Y + 20)
        end
        
        TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateTabSize)
        
        Tab.Frame = TabFrame
        Tab.Layout = TabLayout
        
        -- إضافة زر
        function Tab:CreateButton(text, callback)
            local Button = Instance.new("TextButton")
            Button.Name = text
            Button.Size = UDim2.new(1, 0, 0, 35)
            Button.BackgroundColor3 = DefaultSettings.Theme.Primary
            Button.BorderSizePixel = 0
            Button.Text = text
            Button.TextColor3 = DefaultSettings.Theme.Text
            Button.TextSize = 14
            Button.Font = Enum.Font.Gotham
            Button.Parent = TabFrame
            
            CreateCorner(Button)
            
            Button.MouseEnter:Connect(function()
                CreateTween(Button, {BackgroundColor3 = DefaultSettings.Theme.Accent}):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                CreateTween(Button, {BackgroundColor3 = DefaultSettings.Theme.Primary}):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                CreateTween(Button, {Size = UDim2.new(1, -4, 0, 31)}):Play()
                wait(0.1)
                CreateTween(Button, {Size = UDim2.new(1, 0, 0, 35)}):Play()
                if callback then callback() end
            end)
            
            return Button
        end
        
        -- إضافة تبديل (Toggle)
        function Tab:CreateToggle(text, default, callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = text
            ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
            ToggleFrame.BackgroundColor3 = DefaultSettings.Theme.Surface
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabFrame
            
            CreateCorner(ToggleFrame)
            CreateStroke(ToggleFrame, DefaultSettings.Theme.Secondary)
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = text
            ToggleLabel.TextColor3 = DefaultSettings.Theme.Text
            ToggleLabel.TextSize = 14
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleButton.BackgroundColor3 = default and DefaultSettings.Theme.Success or DefaultSettings.Theme.Secondary
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            CreateCorner(ToggleButton, UDim.new(0, 10))
            
            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
            ToggleIndicator.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            ToggleIndicator.BackgroundColor3 = DefaultSettings.Theme.Text
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Parent = ToggleButton
            
            CreateCorner(ToggleIndicator, UDim.new(0, 8))
            
            local isToggled = default or false
            
            ToggleButton.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                
                local newColor = isToggled and DefaultSettings.Theme.Success or DefaultSettings.Theme.Secondary
                local newPos = isToggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                
                CreateTween(ToggleButton, {BackgroundColor3 = newColor}):Play()
                CreateTween(ToggleIndicator, {Position = newPos}):Play()
                
                if callback then callback(isToggled) end
            end)
            
            return ToggleFrame
        end
        
        -- إضافة شريط التمرير (Slider)
        function Tab:CreateSlider(text, min, max, default, callback)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = text
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)
            SliderFrame.BackgroundColor3 = DefaultSettings.Theme.Surface
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabFrame
            
            CreateCorner(SliderFrame)
            CreateStroke(SliderFrame, DefaultSettings.Theme.Secondary)
            CreatePadding(SliderFrame)
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Size = UDim2.new(1, -60, 0, 20)
            SliderLabel.Position = UDim2.new(0, 0, 0, 0)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = text
            SliderLabel.TextColor3 = DefaultSettings.Theme.Text
            SliderLabel.TextSize = 14
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.Parent = SliderFrame
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0, 50, 0, 20)
            ValueLabel.Position = UDim2.new(1, -50, 0, 0)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(default)
            ValueLabel.TextColor3 = DefaultSettings.Theme.Primary
            ValueLabel.TextSize = 14
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.Parent = SliderFrame
            
            local SliderBar = Instance.new("Frame")
            SliderBar.Size = UDim2.new(1, 0, 0, 4)
            SliderBar.Position = UDim2.new(0, 0, 1, -14)
            SliderBar.BackgroundColor3 = DefaultSettings.Theme.Secondary
            SliderBar.BorderSizePixel = 0
            SliderBar.Parent = SliderFrame
            
            CreateCorner(SliderBar, UDim.new(0, 2))
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            SliderFill.Position = UDim2.new(0, 0, 0, 0)
            SliderFill.BackgroundColor3 = DefaultSettings.Theme.Primary
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderBar
            
            CreateCorner(SliderFill, UDim.new(0, 2))
            
            local SliderButton = Instance.new("TextButton")
            SliderButton.Size = UDim2.new(0, 16, 0, 16)
            SliderButton.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
            SliderButton.BackgroundColor3 = DefaultSettings.Theme.Text
            SliderButton.BorderSizePixel = 0
            SliderButton.Text = ""
            SliderButton.Parent = SliderBar
            
            CreateCorner(SliderButton, UDim.new(0, 8))
            
            local currentValue = default
            local isDragging = false
            
            local function UpdateSlider(value)
                currentValue = math.clamp(value, min, max)
                local percentage = (currentValue - min) / (max - min)
                
                SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                SliderButton.Position = UDim2.new(percentage, -8, 0.5, -8)
                ValueLabel.Text = tostring(math.floor(currentValue * 10) / 10)
                
                if callback then callback(currentValue) end
            end
            
            SliderButton.MouseButton1Down:Connect(function()
                isDragging = true
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local mousePos = input.Position.X
                    local sliderPos = SliderBar.AbsolutePosition.X
                    local sliderSize = SliderBar.AbsoluteSize.X
                    local percentage = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
                    local value = min + (max - min) * percentage
                    UpdateSlider(value)
                end
            end)
            
            return SliderFrame
        end
        
        -- إضافة مربع النص
        function Tab:CreateTextBox(text, placeholder, callback)
            local TextBoxFrame = Instance.new("Frame")
            TextBoxFrame.Name = text
            TextBoxFrame.Size = UDim2.new(1, 0, 0, 35)
            TextBoxFrame.BackgroundColor3 = DefaultSettings.Theme.Surface
            TextBoxFrame.BorderSizePixel = 0
            TextBoxFrame.Parent = TabFrame
            
            CreateCorner(TextBoxFrame)
            CreateStroke(TextBoxFrame, DefaultSettings.Theme.Secondary)
            
            local TextBox = Instance.new("TextBox")
            TextBox.Size = UDim2.new(1, -20, 1, 0)
            TextBox.Position = UDim2.new(0, 10, 0, 0)
            TextBox.BackgroundTransparency = 1
            TextBox.Text = ""
            TextBox.PlaceholderText = placeholder or text
            TextBox.TextColor3 = DefaultSettings.Theme.Text
            TextBox.PlaceholderColor3 = DefaultSettings.Theme.TextSecondary
            TextBox.TextSize = 14
            TextBox.TextXAlignment = Enum.TextXAlignment.Left
            TextBox.Font = Enum.Font.Gotham
            TextBox.ClearTextOnFocus = false
            TextBox.Parent = TextBoxFrame
            
            TextBox.Focused:Connect(function()
                CreateTween(TextBoxFrame, {BackgroundColor3 = DefaultSettings.Theme.Background}):Play()
                local stroke = TextBoxFrame:FindFirstChild("UIStroke")
                if stroke then
                    CreateTween(stroke, {Color = DefaultSettings.Theme.Primary}):Play()
                end
            end)
            
            TextBox.FocusLost:Connect(function()
                CreateTween(TextBoxFrame, {BackgroundColor3 = DefaultSettings.Theme.Surface}):Play()
                local stroke = TextBoxFrame:FindFirstChild("UIStroke")
                if stroke then
                    CreateTween(stroke, {Color = DefaultSettings.Theme.Secondary}):Play()
                end
                if callback then callback(TextBox.Text) end
            end)
            
            return TextBox
        end
        
        -- إضافة قائمة منسدلة
        function Tab:CreateDropdown(text, options, callback)
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Name = text
            DropdownFrame.Size = UDim2.new(1, 0, 0, 35)
            DropdownFrame.BackgroundColor3 = DefaultSettings.Theme.Surface
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Parent = TabFrame
            DropdownFrame.ClipsDescendants = true
            
            CreateCorner(DropdownFrame)
            CreateStroke(DropdownFrame, DefaultSettings.Theme.Secondary)
            
            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Size = UDim2.new(1, 0, 0, 35)
            DropdownButton.Position = UDim2.new(0, 0, 0, 0)
            DropdownButton.BackgroundTransparency = 1
            DropdownButton.Text = text
            DropdownButton.TextColor3 = DefaultSettings.Theme.Text
            DropdownButton.TextSize = 14
            DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
            DropdownButton.Font = Enum.Font.Gotham
            DropdownButton.Parent = DropdownFrame
            
            CreatePadding(DropdownButton)
            
            local DropdownArrow = Instance.new("TextLabel")
            DropdownArrow.Size = UDim2.new(0, 20, 1, 0)
            DropdownArrow.Position = UDim2.new(1, -30, 0, 0)
            DropdownArrow.BackgroundTransparency = 1
            DropdownArrow.Text = "▼"
            DropdownArrow.TextColor3 = DefaultSettings.Theme.TextSecondary
            DropdownArrow.TextSize = 12
            DropdownArrow.Font = Enum.Font.Gotham
            DropdownArrow.Parent = DropdownButton
            
            local isOpen = false
            local selectedOption = nil
            
            local function CreateOption(option, index)
                local OptionButton = Instance.new("TextButton")
                OptionButton.Size = UDim2.new(1, 0, 0, 30)
                OptionButton.Position = UDim2.new(0, 0, 0, 35 + (index - 1) * 30)
                OptionButton.BackgroundColor3 = DefaultSettings.Theme.Background
                OptionButton.BorderSizePixel = 0
                OptionButton.Text = option
                OptionButton.TextColor3 = DefaultSettings.Theme.Text
                OptionButton.TextSize = 13
                OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.Parent = DropdownFrame
                
                CreatePadding(OptionButton)
                
                OptionButton.MouseEnter:Connect(function()
                    CreateTween(OptionButton, {BackgroundColor3 = DefaultSettings.Theme.Primary}):Play()
                end)
                
                OptionButton.MouseLeave:Connect(function()
                    CreateTween(OptionButton, {BackgroundColor3 = DefaultSettings.Theme.Background}):Play()
                end)
                
                OptionButton.MouseButton1Click:Connect(function()
                    selectedOption = option
                    DropdownButton.Text = option
                    isOpen = false
                    
                    CreateTween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 35)}):Play()
                    CreateTween(DropdownArrow, {Rotation = 0}):Play()
                    
                    if callback then callback(option) end
                end)
                
                return OptionButton
            end
            
            -- إنشاء الخيارات
            for i, option in ipairs(options) do
                CreateOption(option, i)
            end
            
            DropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                
                if isOpen then
                    local targetSize = UDim2.new(1, 0, 0, 35 + #options * 30)
                    CreateTween(DropdownFrame, {Size = targetSize}):Play()
                    CreateTween(DropdownArrow, {Rotation = 180}):Play()
                else
                    CreateTween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 35)}):Play()
                    CreateTween(DropdownArrow, {Rotation = 0}):Play()
                end
            end)
            
            return DropdownFrame
        end
        
        -- إضافة تسمية
        function Tab:CreateLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Name = text
            Label.Size = UDim2.new(1, 0, 0, 25)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = DefaultSettings.Theme.TextSecondary
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Font = Enum.Font.Gotham
            Label.Parent = TabFrame
            
            return Label
        end
        
        -- إضافة فاصل
        function Tab:CreateSeparator()
            local Separator = Instance.new("Frame")
            Separator.Name = "Separator"
            Separator.Size = UDim2.new(1, 0, 0, 1)
            Separator.BackgroundColor3 = DefaultSettings.Theme.Secondary
            Separator.BorderSizePixel = 0
            Separator.Parent = TabFrame
            
            return Separator
        end
        
        -- إضافة صندوق ألوان
        function Tab:CreateColorPicker(text, default, callback)
            local ColorFrame = Instance.new("Frame")
            ColorFrame.Name = text
            ColorFrame.Size = UDim2.new(1, 0, 0, 35)
            ColorFrame.BackgroundColor3 = DefaultSettings.Theme.Surface
            ColorFrame.BorderSizePixel = 0
            ColorFrame.Parent = TabFrame
            
            CreateCorner(ColorFrame)
            CreateStroke(ColorFrame, DefaultSettings.Theme.Secondary)
            
            local ColorLabel = Instance.new("TextLabel")
            ColorLabel.Size = UDim2.new(1, -50, 1, 0)
            ColorLabel.Position = UDim2.new(0, 10, 0, 0)
            ColorLabel.BackgroundTransparency = 1
            ColorLabel.Text = text
            ColorLabel.TextColor3 = DefaultSettings.Theme.Text
            ColorLabel.TextSize = 14
            ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
            ColorLabel.Font = Enum.Font.Gotham
            ColorLabel.Parent = ColorFrame
            
            local ColorPreview = Instance.new("Frame")
            ColorPreview.Size = UDim2.new(0, 30, 0, 25)
            ColorPreview.Position = UDim2.new(1, -40, 0.5, -12.5)
            ColorPreview.BackgroundColor3 = default or DefaultSettings.Theme.Primary
            ColorPreview.BorderSizePixel = 0
            ColorPreview.Parent = ColorFrame
            
            CreateCorner(ColorPreview, UDim.new(0, 4))
            
            local ColorButton = Instance.new("TextButton")
            ColorButton.Size = UDim2.new(1, 0, 1, 0)
            ColorButton.BackgroundTransparency = 1
            ColorButton.Text = ""
            ColorButton.Parent = ColorPreview
            
            ColorButton.MouseButton1Click:Connect(function()
                -- هنا يمكنك إضافة نافذة اختيار الألوان المخصصة
                if callback then callback(ColorPreview.BackgroundColor3) end
            end)
            
            return ColorFrame
        end
        
        return Tab
    end
    
    -- إضافة إشعار
    function Window:CreateNotification(title, text, duration)
        duration = duration or 3
        
        local NotificationFrame = Instance.new("Frame")
        NotificationFrame.Size = UDim2.new(0, 300, 0, 80)
        NotificationFrame.Position = UDim2.new(1, -320, 1, -100)
        NotificationFrame.BackgroundColor3 = DefaultSettings.Theme.Surface
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.Parent = ScreenGui
        
        CreateCorner(NotificationFrame)
        CreateStroke(NotificationFrame, DefaultSettings.Theme.Primary)
        CreatePadding(NotificationFrame)
        
        local NotificationTitle = Instance.new("TextLabel")
        NotificationTitle.Size = UDim2.new(1, 0, 0, 20)
        NotificationTitle.BackgroundTransparency = 1
        NotificationTitle.Text = title
        NotificationTitle.TextColor3 = DefaultSettings.Theme.Primary
        NotificationTitle.TextSize = 14
        NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
        NotificationTitle.Font = Enum.Font.GothamBold
        NotificationTitle.Parent = NotificationFrame
        
        local NotificationText = Instance.new("TextLabel")
        NotificationText.Size = UDim2.new(1, 0, 1, -25)
        NotificationText.Position = UDim2.new(0, 0, 0, 25)
        NotificationText.BackgroundTransparency = 1
        NotificationText.Text = text
        NotificationText.TextColor3 = DefaultSettings.Theme.Text
        NotificationText.TextSize = 12
        NotificationText.TextXAlignment = Enum.TextXAlignment.Left
        NotificationText.TextYAlignment = Enum.TextYAlignment.Top
        NotificationText.Font = Enum.Font.Gotham
        NotificationText.TextWrapped = true
        NotificationText.Parent = NotificationFrame
        
        -- تأثير الظهور
        NotificationFrame.Position = UDim2.new(1, 0, 1, -100)
        CreateTween(NotificationFrame, {Position = UDim2.new(1, -320, 1, -100)}):Play()
        
        -- الإخفاء التلقائي
        spawn(function()
            wait(duration)
            CreateTween(NotificationFrame, {Position = UDim2.new(1, 0, 1, -100)}):Play()
            wait(DefaultSettings.Animation.Duration)
            NotificationFrame:Destroy()
        end)
        
        return NotificationFrame
    end
    
    return Window
end

-- إنشاء قائمة سياقية
function UILibrary:CreateContextMenu(options)
    local ContextMenu = Instance.new("Frame")
    ContextMenu.Size = UDim2.new(0, 150, 0, #options * 30)
    ContextMenu.BackgroundColor3 = DefaultSettings.Theme.Surface
    ContextMenu.BorderSizePixel = 0
    ContextMenu.Parent = PlayerGui
    ContextMenu.ZIndex = 1000
    
    CreateCorner(ContextMenu)
    CreateStroke(ContextMenu, DefaultSettings.Theme.Secondary)
    
    local ContextLayout = Instance.new("UIListLayout")
    ContextLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContextLayout.Parent = ContextMenu
    
    for i, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.BackgroundColor3 = Color3.new(0, 0, 0)
        OptionButton.BackgroundTransparency = 1
        OptionButton.BorderSizePixel = 0
        OptionButton.Text = option.Text
        OptionButton.TextColor3 = DefaultSettings.Theme.Text
        OptionButton.TextSize = 13
        OptionButton.TextXAlignment = Enum.TextXAlignment.Left
        OptionButton.Font = Enum.Font.Gotham
        OptionButton.Parent = ContextMenu
        
        CreatePadding(OptionButton, UDim.new(0, 5))
        
        OptionButton.MouseEnter:Connect(function()
            OptionButton.BackgroundTransparency = 0
            OptionButton.BackgroundColor3 = DefaultSettings.Theme.Primary
        end)
        
        OptionButton.MouseLeave:Connect(function()
            OptionButton.BackgroundTransparency = 1
        end)
        
        OptionButton.MouseButton1Click:Connect(function()
            if option.Callback then option.Callback() end
            ContextMenu:Destroy()
        end)
    end
    
    -- إغلاق القائمة عند النقر خارجها
    local function CloseMenu()
        ContextMenu:Destroy()
    end
    
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            CloseMenu()
        end
    end)
    
    -- تحديد موقع القائمة
    local mouse = Player:GetMouse()
    ContextMenu.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
    
    return ContextMenu
end

-- إنشاء نافذة حوار
function UILibrary:CreateDialog(title, text, buttons)
    local DialogFrame = Instance.new("Frame")
    DialogFrame.Size = UDim2.new(0, 400, 0, 200)
    DialogFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    DialogFrame.BackgroundColor3 = DefaultSettings.Theme.Background
    DialogFrame.BorderSizePixel = 0
    DialogFrame.Parent = PlayerGui
    DialogFrame.ZIndex = 1000
    
    CreateCorner(DialogFrame)
    CreateStroke(DialogFrame, DefaultSettings.Theme.Primary, 2)
    
    -- خلفية شفافة
    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    Overlay.BackgroundTransparency = 0.5
    Overlay.BorderSizePixel = 0
    Overlay.Parent = PlayerGui
    Overlay.ZIndex = 999
    
    -- شريط العنوان
    local DialogTitle = Instance.new("TextLabel")
    DialogTitle.Size = UDim2.new(1, 0, 0, 40)
    DialogTitle.BackgroundColor3 = DefaultSettings.Theme.Primary
    DialogTitle.BorderSizePixel = 0
    DialogTitle.Text = title
    DialogTitle.TextColor3 = DefaultSettings.Theme.Text
    DialogTitle.TextSize = 16
    DialogTitle.Font = Enum.Font.GothamBold
    DialogTitle.Parent = DialogFrame
    
    CreateCorner(DialogTitle, UDim.new(0, 8))
    
    -- النص
    local DialogText = Instance.new("TextLabel")
    DialogText.Size = UDim2.new(1, -40, 1, -100)
    DialogText.Position = UDim2.new(0, 20, 0, 50)
    DialogText.BackgroundTransparency = 1
    DialogText.Text = text
    DialogText.TextColor3 = DefaultSettings.Theme.Text
    DialogText.TextSize = 14
    DialogText.Font = Enum.Font.Gotham
    DialogText.TextWrapped = true
    DialogText.TextYAlignment = Enum.TextYAlignment.Top
    DialogText.Parent = DialogFrame
    
    -- منطقة الأزرار
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Size = UDim2.new(1, -40, 0, 40)
    ButtonFrame.Position = UDim2.new(0, 20, 1, -50)
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.Parent = DialogFrame
    
    local ButtonLayout = Instance.new("UIListLayout")
    ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
    ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ButtonLayout.Padding = UDim.new(0, 10)
    ButtonLayout.Parent = ButtonFrame
    
    -- إنشاء الأزرار
    for i, button in ipairs(buttons) do
        local DialogButton = Instance.new("TextButton")
        DialogButton.Size = UDim2.new(0, 80, 1, 0)
        DialogButton.BackgroundColor3 = button.Primary and DefaultSettings.Theme.Primary or DefaultSettings.Theme.Secondary
        DialogButton.BorderSizePixel = 0
        DialogButton.Text = button.Text
        DialogButton.TextColor3 = DefaultSettings.Theme.Text
        DialogButton.TextSize = 14
        DialogButton.Font = Enum.Font.Gotham
        DialogButton.LayoutOrder = i
        DialogButton.Parent = ButtonFrame
        
        CreateCorner(DialogButton)
        
        DialogButton.MouseEnter:Connect(function()
            local hoverColor = button.Primary and DefaultSettings.Theme.Accent or DefaultSettings.Theme.Surface
            CreateTween(DialogButton, {BackgroundColor3 = hoverColor}):Play()
        end)
        
        DialogButton.MouseLeave:Connect(function()
            local normalColor = button.Primary and DefaultSettings.Theme.Primary or DefaultSettings.Theme.Secondary
            CreateTween(DialogButton, {BackgroundColor3 = normalColor}):Play()
        end)
        
        DialogButton.MouseButton1Click:Connect(function()
            if button.Callback then button.Callback() end
            
            CreateTween(DialogFrame, {Size = UDim2.new(0, 0, 0, 0)}):Play()
            CreateTween(Overlay, {BackgroundTransparency = 1}):Play()
            
            wait(DefaultSettings.Animation.Duration)
            DialogFrame:Destroy()
            Overlay:Destroy()
        end)
    end
  end
  return UILibrary
