---
title: "Converting MKV to MP4 with FFmpeg"
date: 2024-11-21T08:00:00+10:00
tags: ["ffmpeg", "MKV to MP4", "Video Conversion", "Video Encoding", "H.264"]
author: danijeljw
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Learn how to convert MKV files to MP4 format using FFmpeg with both fast copying and re-encoding methods. Understand presets, advanced options, and best practices."
disableHLJS: false
hideSummary: false
searchHidden: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
cover:
    image: /images/logos/568px-FFmpeg-Logo.png # image path/url
    alt: "FFmpeg Logo" # alt text
    caption: '' # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

## Convert MKV to MP4 with FFmpeg

### Fast Conversion (Without Re-encoding)

To convert a video file from `.mkv` to `.mp4` using FFmpeg without re-encoding:

```bash
ffmpeg -i input.mkv -c:v copy -c:a copy output.mp4
```

#### Explanation:

- `-i input.mkv`: Specifies the input file
- `c:v copy`: Copies the video stream without re-encoding.
- `c:a copy`: Copies the audio stream without re-encoding.
- `output.mp4`: Specifies the output file.

##### Why Use This Method?

- **Speed:** No re-encoding is required, making it much faster.
- **Compatibility:** Works only if the MKV file contains codecs supported by the MP4 container (e.g., H.264 for video and AAC for audio).

## Re-encoding for Compatibility

If the codecs in the MKV file are incompatible with the MP4 container, re-encoding is necessary:

```bash
ffmpeg -i input.mkv -c:v libx264 -crf 23 -preset fast -c:a aac -b:a 192k output.mp4
```

#### Explanation:
- `c:v libx264`: Re-encodes the video using the H.264 codec.
- `crf 23`: Sets the quality (lower values mean better quality, default is 23).
- `preset fast`: Balances encoding speed and compression.
- `c:a aac`: Re-encodes the audio using the AAC codec.
- `b:a 192k`: Sets the audio bitrate to 192 kbps.

## Advanced Options

### Add Metadata

To copy metadata from the original file:

```bash
ffmpeg -i input.mkv -c:v copy -c:a copy -map_metadata 0 output.mp4
```

### Subtitles

#### Include subtitles

```bash
ffmpeg -i input.mkv -c:v copy -c:a copy -c:s mov_text output.mp4
```

#### Exclude subtitles

```bash
ffmpeg -i input.mkv -c:v copy -c:a copy -sn output.mp4
```

### Verifying the Converstion

After conversion, verify the codes and container cormat of the output file:

```bash
ffprobe output.mp4
```

## Understanding Presets in FFmpeg

When re-encoding video using the H.264 codec (`libx264`), FFmpeg provides several presets to balance speed and compression efficiency.

### Preset List (Fastest to Slowest)

| Preset | Encoding Speed | File Size | Compression Efficiency |
|:-------|:---------------|:----------|:-----------------------|
| ultrafast | Fastest | Largest | Lowest |
| superfast | Very Fast | Larger | Low |
| veryfast | Fast | Large | Moderate |
| faster | Moderately Fast | Medium-Large | Moderate |
| fast | Moderate | Medium | Good |
| medium | Balanced (Default) | Medium | Good |
| slow | Slow | Smaller | Better |
| slower | Very Slow | Smaller | Better |
| veryslow | Extremely Slow | Smallest | Best |
| placebo | Impossibly Slow | Smallest Possible | Overkill (Not Worth It) |

### Choosing the Right Preset

1. **For Speed:** Use `ultrafast`, `superfast`, or `veryfast`.
1. **For General Use:** Stick with the default `medium` preset.
1. **For High-Quality Output:** Use `slow` or `veryslow`.
1. **Avoid** `placebo`: It provides negligible benefits comparted to the time required.

### Example Command with Preset:

```bash
ffmpeg -i input.mkv -c:v libx264 -preset veryfast -crf 23 -c:a aac output.mp4
```

## Conclusion

FFmpeg is a powerful tool for video conversion, offering a wide range of options to suit various needs. Whether you prioritize speed, quality, or file size, FFmpeg provides the flexibility to meet your requirements.

- **For fast, lossless conversions:** Use the `-c:v copy -c:a copy` method to avoid re-encoding.
- **For compatibility or custom compression:** Leverage the H.264 codec with the appropriate preset and `crf` values.
- **For advanced needs:** Explore metadata handling, subtitle management, and verification tools like `ffprobe`.

By understanding and combining presets with the `crf` value, you can achieve the perfect balance between speed, quality, and file size for your video conversions.