Add-Type -AssemblyName System.Drawing

$sourcePath = "c:\Users\jixia\Desktop\MyBlog\static\images\avatar.jpg"
$destPath = "c:\Users\jixia\Desktop\MyBlog\static\images\favicon.png"
$borderColor = [System.Drawing.Color]::FromArgb(37, 99, 235) # #2563eb
$backgroundColor = [System.Drawing.Color]::White
$size = 256
$borderWidth = 12  # 边框宽度
$gapWidth = 12     # 留白宽度

# Load image
if (-not (Test-Path $sourcePath)) {
    Write-Error "Source image not found: $sourcePath"
    exit 1
}

$srcImage = [System.Drawing.Image]::FromFile($sourcePath)

# Create new bitmap
$format = [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
$bmp = New-Object System.Drawing.Bitmap $size, $size, $format
$g = [System.Drawing.Graphics]::FromImage($bmp)

$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

# 1. Draw White Background (creates the gap)
$fullRect = New-Object System.Drawing.Rectangle 0, 0, $size, $size
$whiteBrush = New-Object System.Drawing.SolidBrush $backgroundColor
$g.FillEllipse($whiteBrush, $fullRect)

# 2. Draw Avatar (Centered and Clipped)
# Calculate avatar rect: shrink by border + gap
$totalInset = $borderWidth + $gapWidth
$avatarRect = New-Object System.Drawing.Rectangle $totalInset, $totalInset, ($size - 2*$totalInset), ($size - 2*$totalInset)

# Create clip path for avatar
$avatarPath = New-Object System.Drawing.Drawing2D.GraphicsPath
$avatarPath.AddEllipse($avatarRect)

$g.SetClip($avatarPath)
$g.DrawImage($srcImage, $avatarRect)
$g.ResetClip()

# 3. Draw Blue Border
# Use Inset alignment to draw inside the bounds
$pen = New-Object System.Drawing.Pen $borderColor, $borderWidth
$pen.Alignment = [System.Drawing.Drawing2D.PenAlignment]::Inset
$g.DrawEllipse($pen, $fullRect)

# Save
$bmp.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)

# Cleanup
$pen.Dispose()
$whiteBrush.Dispose()
$avatarPath.Dispose()
$g.Dispose()
$bmp.Dispose()
$srcImage.Dispose()

Write-Host "Favicon generated at $destPath"
