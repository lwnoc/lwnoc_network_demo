from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont


WIDTH = 720
HEIGHT = 1280

WORKSPACE = Path("/home/lgzhu/dev/noc_work/lwnoc_sts_noc")
OUTPUT = Path("/mnt/e/invitation_target_style.png")


def load_font(candidates, size):
    for candidate in candidates:
        path = Path(candidate)
        if path.exists():
            return ImageFont.truetype(str(path), size=size)
    return ImageFont.load_default()


FONT_CN_BOLD = load_font(
    [
        "/usr/share/fonts/truetype/droid/DroidSansFallbackFull.ttf",
        "/usr/share/fonts/truetype/arphic-gbsn00lp/gbsn00lp.ttf",
    ],
    104,
)
FONT_CN_TITLE = load_font(
    [
        "/usr/share/fonts/truetype/droid/DroidSansFallbackFull.ttf",
        "/usr/share/fonts/truetype/arphic-gbsn00lp/gbsn00lp.ttf",
    ],
    148,
)
FONT_CN_MED = load_font(
    [
        "/usr/share/fonts/truetype/droid/DroidSansFallbackFull.ttf",
        "/usr/share/fonts/truetype/arphic-gbsn00lp/gbsn00lp.ttf",
    ],
    34,
)
FONT_CN_SMALL = load_font(
    [
        "/usr/share/fonts/truetype/droid/DroidSansFallbackFull.ttf",
        "/usr/share/fonts/truetype/arphic-gbsn00lp/gbsn00lp.ttf",
    ],
    26,
)
FONT_EN_BOLD = load_font(
    [
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf",
        "/usr/share/fonts/truetype/liberation2/LiberationSans-Bold.ttf",
    ],
    32,
)
FONT_EN_SMALL = load_font(
    [
        "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
        "/usr/share/fonts/truetype/liberation2/LiberationSans-Regular.ttf",
    ],
    22,
)


def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))


def make_background():
    image = Image.new("RGB", (WIDTH, HEIGHT))
    pixels = image.load()

    top = (255, 241, 136)
    middle = (255, 210, 76)
    bottom = (255, 120, 21)

    for y in range(HEIGHT):
        t = y / (HEIGHT - 1)
        if t < 0.55:
            row = lerp(top, middle, t / 0.55)
        else:
            row = lerp(middle, bottom, (t - 0.55) / 0.45)
        for x in range(WIDTH):
            shift = int(22 * (x / WIDTH) - 8 * (y / HEIGHT))
            pixels[x, y] = tuple(max(0, min(255, channel + shift)) for channel in row)

    overlay = Image.new("RGBA", (WIDTH, HEIGHT), (0, 0, 0, 0))
    glow = ImageDraw.Draw(overlay)
    glow.ellipse((-220, -120, 560, 520), fill=(255, 255, 255, 110))
    glow.ellipse((360, 720, 1050, 1480), fill=(255, 170, 42, 100))
    overlay = overlay.filter(ImageFilter.GaussianBlur(80))
    return Image.alpha_composite(image.convert("RGBA"), overlay)


def add_wave(layer, points, fill, blur_radius=10):
    shape = Image.new("RGBA", (WIDTH, HEIGHT), (0, 0, 0, 0))
    draw = ImageDraw.Draw(shape)
    draw.polygon(points, fill=fill)
    if blur_radius:
        shape = shape.filter(ImageFilter.GaussianBlur(blur_radius))
    return Image.alpha_composite(layer, shape)


def text_box(draw, position, text, font, fill, anchor="la", stroke_width=0, stroke_fill=None):
    draw.text(
        position,
        text,
        font=font,
        fill=fill,
        anchor=anchor,
        stroke_width=stroke_width,
        stroke_fill=stroke_fill,
    )


def center_x(draw, text, font, stroke_width=0):
    left, _, right, _ = draw.textbbox((0, 0), text, font=font, stroke_width=stroke_width)
    return (WIDTH - (right - left)) / 2


def main():
    image = make_background()

    image = add_wave(
        image,
        [(-120, 160), (310, 80), (850, 210), (850, 520), (460, 480), (120, 560), (-120, 460)],
        (255, 255, 255, 105),
        blur_radius=14,
    )
    image = add_wave(
        image,
        [(-140, 740), (160, 640), (470, 480), (870, 460), (860, 760), (480, 900), (110, 1060), (-140, 970)],
        (255, 216, 104, 128),
        blur_radius=12,
    )
    image = add_wave(
        image,
        [(400, 860), (640, 760), (840, 780), (860, 1180), (580, 1320), (370, 1200)],
        (255, 91, 23, 120),
        blur_radius=24,
    )
    image = add_wave(
        image,
        [(-80, 920), (230, 980), (500, 920), (840, 780), (840, 1010), (500, 1160), (110, 1210), (-80, 1130)],
        (255, 255, 255, 45),
        blur_radius=8,
    )

    draw = ImageDraw.Draw(image)

    text_box(draw, (44, 72), "川流投资", FONT_CN_MED, (255, 255, 255, 240))
    text_box(draw, (44, 110), "LWCAPITAL", FONT_EN_SMALL, (255, 255, 255, 220))

    text_box(draw, (676, 78), "2025川流投资者日", FONT_CN_SMALL, (255, 255, 255, 235), anchor="ra")
    text_box(draw, (676, 116), "Investor Day Invitation", FONT_EN_SMALL, (255, 255, 255, 210), anchor="ra")

    title_shadow = (255, 140, 38, 150)
    title_fill = (255, 255, 255, 248)
    title_x = 56
    text_box(draw, (title_x + 5, 284), "邀", FONT_CN_TITLE, title_shadow, stroke_width=2, stroke_fill=title_shadow)
    text_box(draw, (title_x, 278), "邀", FONT_CN_TITLE, title_fill, stroke_width=2, stroke_fill=(255, 213, 109, 220))
    text_box(draw, (title_x, 420), "请", FONT_CN_TITLE, title_fill, stroke_width=2, stroke_fill=(255, 213, 109, 220))
    text_box(draw, (title_x, 562), "函", FONT_CN_TITLE, title_fill, stroke_width=2, stroke_fill=(255, 213, 109, 220))

    text_box(draw, (416, 340), "INVITATION", FONT_EN_BOLD, (255, 255, 255, 228), anchor="mm")
    draw.line((562, 210, 562, 782), fill=(255, 255, 255, 220), width=3)
    for dot_x in (630, 654, 678):
        draw.ellipse((dot_x - 5, 818 - 5, dot_x + 5, 818 + 5), fill=(255, 255, 255, 235))

    detail_top = 870
    draw.line((56, detail_top, 664, detail_top), fill=(255, 255, 255, 185), width=2)
    draw.line((56, detail_top + 2, 664, detail_top + 2), fill=(255, 232, 170, 120), width=1)

    detail_fill = (255, 255, 255, 238)
    accent_fill = (255, 246, 196, 242)

    lines = [
        ("地点", "鲁能JW万豪侯爵酒店"),
        ("楼层", "一楼荣膺厅"),
        ("地址", "上海市浦东新区浦明路988号"),
    ]
    y = 910
    for label, value in lines:
        text_box(draw, (60, y), label, FONT_CN_SMALL, accent_fill)
        text_box(draw, (138, y), value, FONT_CN_SMALL, detail_fill)
        y += 54

    date_text = "2026年4月16日 12时45分"
    date_x = center_x(draw, date_text, FONT_CN_MED)
    text_box(draw, (date_x, 1090), date_text, FONT_CN_MED, (255, 255, 255, 242))

    draw.rounded_rectangle((240, 1160, 480, 1222), radius=28, outline=(255, 255, 255, 200), width=2, fill=(255, 255, 255, 24))
    brand_x = center_x(draw, "川流投资", FONT_CN_SMALL)
    text_box(draw, (brand_x, 1174), "川流投资", FONT_CN_SMALL, (255, 255, 255, 236))

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    image.convert("RGB").save(OUTPUT, quality=96)
    print(OUTPUT)


if __name__ == "__main__":
    main()