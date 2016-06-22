static class Slider {
  public static final int VERTICAL = 98443;
  public static final int HORIZONTAL = 48251;

  public static final int CENTERED = 4187341;
  public static final int ENDPOINT = 57813;

  SliderDataSource src;
  float x, y, size;
  float sliderHandleSize = 10, sliderHandleWidth = 30;
  int orientation, alignment;
  String name;

  boolean zeroLine = true;

  public Slider(SliderDataSource src, float x, float y, float size, int orientation, int alignment, String name) {
    this.src = src;
    this.x = x;
    this.y = y;
    this.size = size;
    this.orientation = orientation;
    this.alignment = alignment;
    this.name = name;
  }

  public void drawSlider(PGraphics pg) {
    float val = src.getRatio();

    pg.stroke(255);
    pg.strokeWeight(5);
    pg.noFill();
    pg.strokeCap(MITER);
    if (alignment == ENDPOINT) {
    }

    if (orientation == VERTICAL) {
      pg.line(x, y - size / 2.0, x, y + size / 2.0);
      pg.strokeWeight(2);
      pg.stroke(255, 100);
      pg.fill(255);
      pg.noStroke();
      pg.rect(x, y + (val - 0.5) * size, sliderHandleWidth, sliderHandleSize);

      pg.text(name, x, y - size / 2.0);

      pg.fill(255, 100);
      pg.noStroke();
      pg.rect(x, y + (src.valueToRatio(0) - 0.5) * size, sliderHandleWidth, 1);
    } else if (orientation == HORIZONTAL) {
      pg.line(x - size / 2.0, y, x + size / 2.0, y);
      pg.fill(255);
      pg.noStroke();
      pg.rect(x + (val - 0.5) * size, y, sliderHandleSize, sliderHandleWidth);

      pg.textAlign(RIGHT);
      pg.text(name, x - size / 2.0 - 5, y + 5);

      pg.fill(255, 100);
      pg.noStroke();
      pg.rect(x + (src.valueToRatio(0) - 0.5) * size, y, 1, sliderHandleWidth);
    } else {
      logger(this, "drawSlider error 1");
    }
  } /* drawSlider */
}

static abstract class SliderDataSource {
  abstract float getValue();
  abstract float getMax();
  abstract float getMin();
  float getRatio() {
    return valueToRatio(getValue());
  }
  float valueToRatio(float value) {
    return (value - getMin()) / (getMax() - getMin());
  }
}