# Vertical-Text-iOS
This project demonstrates how to render vertical text in iOS. It is vaguely inspired by the sample code [TextLayoutDemo][1] for OS X.

Features:

- **Renders using TextKit**, so handles all the text layout features available in iOS: kerning, hypenation, control and invisible characters, rich text support...
- Text direction/orientation modifications are easy to make.
- **Doesn't support text selection** yet. It renders in a UIView instead of a UITextView. **Please, help with that.**
- There is no scrolling yet, but that shouldn't be difficult.

![Screenshot](Screenshot.png)

## Key concepts

The class `NSTextContainer` handles the rect of each line. We subclassed it.

I tried subclassing `UITextView` to control the rendering, but it was a mess. So for demonstration purposes, I implemented a custom `UIView` applying some affine transformations to each line of text vertically readable from top-left to bottom-right.


[1]: https://developer.apple.com/library/mac/samplecode/TextLayoutDemo/Introduction/Intro.html
