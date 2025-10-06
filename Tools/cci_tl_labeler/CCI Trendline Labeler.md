# CCI Trendline Labeler

This tool manages the process of exporting, labeling, and analyzing **CCI trendline data** across multiple timeframes (M5 → W1).  
It is designed as a research companion to identify which CCI-based trendline patterns are worth trading.

---

## 📂 Folder Structure

cci_tl_labeler/
│
├── data/        # Raw exported CSVs from MT5 (per timeframe)
├── fit/         # Processed, labeled, or model outputs
├── scripts/     # Exporter and analysis scripts (MQL5/Python)
└── README.md    # This document

---

## 🔄 Workflow

[MT5 Exporter Script] +
        ↓
   (CSV in data/)
        ↓
   [Manual / Assisted Labeling]
        ↓
 (Labeled CSV → fit/)
        ↓
   [Python Analysis / Fitter]
        ↓
  (Reports, stats, models)

- **Export** → Use the MT5 exporter to dump raw values.  
- **Label** → Mark valid breaks, rejections, or failures.  
- **Fit** → Run scripts to test predictive strength of patterns.  

---

## 📝 Notes

- Always keep `data/` **raw and untouched** (for reproducibility).  
- Place cleaned or labeled versions into `fit/`.  
- Scripts in `scripts/` should log their steps for later replay.  
- Version control (Git) recommended so results can be traced back to the exact data and code used.  

---

**Version:** 0.1 (setup complete)