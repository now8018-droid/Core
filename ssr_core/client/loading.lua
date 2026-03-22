CreateThread(function()
    -- รอเกมโหลด player เสร็จ
    while not NetworkIsSessionStarted() do
        Wait(100)
    end

    Wait(500)

    -- ปิด Loading Screen (NUI)
    ShutdownLoadingScreenNui()

    -- ปิด Loading Screen ปกติ
    ShutdownLoadingScreen()

    -- กันซ้ำอีกครั้ง (กันบางเซิร์ฟเวอร์ค้าง)
    Wait(1000)
    ShutdownLoadingScreenNui()
    ShutdownLoadingScreen()
end)