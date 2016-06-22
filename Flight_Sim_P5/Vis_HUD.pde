static class HUD {
  public static final int VERTICAL = 98443;
  public static final int HORIZONTAL = 48251;

  public static final int CENTERED = 4187341;
  public static final int ENDPOINT = 57813;

  HudDataSource src;
  float x, y, size;
  float sliderHandleSize = 10, sliderHandleWidth = 30;
  int orientation, alignment;
  String name;

  boolean zeroLine = true;

  public HUD(HudDataSource src, float x, float y, float size, int orientation, int alignment, String name) {
    this.src = src;
    this.x = x;
    this.y = y;
    this.size = size;
    this.orientation = orientation;
    this.alignment = alignment;
    this.name = name;
  }

  public void drawHUD(PGraphics pg) {
    float val = src.getValue();
    float range = src.getDisplayRange();
    float spacing = src.getTickerSpacing();

    float pxPerValue = size / range;

    float displayMin = val - range / 2.0;
    float displayMax = val + range / 2.0;

    int dispalyTickerIndexMin = floor(displayMin / spacing);
    int dispalyTickerIndexMax = floor(displayMax / spacing);

    pg.noStroke();
    pg.fill(0, 255, 0);

    pg.strokeCap(MITER);

    pg.pushMatrix();
    pg.translate(x, y);
    if (alignment == ENDPOINT) {
    }

    if (orientation == VERTICAL) {
      // logger(this,val,pxPerValue,displayMin,displayMax,dispalyTickerIndexMin,dispalyTickerIndexMax);
      drawPolygon(pg, 10, 0, 3);

      pg.strokeWeight(2);
      pg.textSize(16);
      pg.textAlign(RIGHT);

      pg.text(name, -10, 5);
      pg.textAlign(LEFT);

      for (int i = dispalyTickerIndexMin; i <= dispalyTickerIndexMax; i++) {
        float lineY = -(i * spacing - val) * pxPerValue;
        // logger(this,lineY);
        pg.noFill();
        pg.stroke(0, 255, 0);
        pg.line(10, lineY, 30, lineY);
        pg.fill(0, 255, 0);
        pg.noStroke();
        pg.text("" + i * spacing, 40, lineY + 6);
      }
    } else if (orientation == HORIZONTAL) {
    } else {
      logger(this, "drawSlider error 1");
    }

    pg.popMatrix();
  } /* drawHUD */
}

static abstract class HudDataSource {
  abstract float getValue();
  abstract float getDisplayRange();
  abstract float getTickerSpacing();
}