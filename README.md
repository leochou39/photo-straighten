# 我最正直

網站：https://leochou39.github.io/photo-straighten/

上傳照片，自動偵測畫面裡的直線，產生三種拉直結果（水平校正、垂直校正、完整校正），選一個後可以再用滑桿微調（旋轉、垂直／水平透視、長寬比），確定後存回手機。照片只在瀏覽器裡處理，不會上傳。

## 加到 iPhone 主畫面

用 Safari 打開網站 → 分享按鈕 →「加入主畫面」。

## 檔案

| 檔案 | 說明 |
| --- | --- |
| `index.html` | 頁面內容（樣式與程式都在裡面），也是 Claude Artifact 版本的原始檔 |
| `assets/apple-touch-icon.png` | 主畫面圖示 |
| `assets/sample.jpg` | 開啟時的範例照片 |
| `build_site.sh` | 把網頁打包到 `docs/`，GitHub Pages 從這裡發佈 |

## 更新網站

```sh
./build_site.sh
git add -A && git commit -m "說明" && git push
```

## 原理

1. 縮小到 1024 px，找出梯度方向一致的像素區塊，擬合成線段。
2. 接近垂直、接近水平的線段分別用 RANSAC 找消失點。
3. 依 EXIF 等效焦距（沒有就用 26 mm）把消失點換成相機方向，算出要轉多少角度，再以 H = K·R·K⁻¹ 重新投影。
4. 自動裁出保持原比例的最大矩形。
