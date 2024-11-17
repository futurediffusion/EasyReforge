# EasyReforge

[reForge](https://github.com/Panchovix/stable-diffusion-webui-reForge) でお手軽に高速画像生成する EasyReforge です。  
現在は [NoobAi (Epsilon-Pred & V-Pred)](https://civitai.com/models/833294) を中心に扱います。

- ワンクリックインストール
- Geforce RTX 3060 VRAM 12GB で FullHD を 11秒で生成するプリセット
	- Geforce GTX 1660 Ti VRAM 6GB でも一応動作します（FullHD 100秒弱）。
- 軽く動作確認済みの拡張機能一式を組み込み
- Civitai キー設定でモデル・LoRA・Wildcard・ADetailer モデルなど一式をダウンロード

わからないことや要望や不具合がありましたら、 [@Zuntan03](https://x.com/Zuntan03) や [Issues](https://github.com/Zuntan03/EasyReforge/issues) にお知らせください。

## インストール方法

1. NVIDIA GPU の Windows PC で [EasyReforgeInstaller.bat](https://github.com/Zuntan03/EasyReforge/raw/main/EasyReforge/EasyReforgeInstaller.bat?ver=0) を右クリックから保存します。
2. `C:/EasyReforge/` などの浅いインストール先フォルダで `EasyReforgeInstaller.bat` をダブルクリックして実行します。
   - **`WindowsによってPCが保護されました` と表示されたら、`詳細表示` から `実行` します。**
3. 指示に沿ってインストールとモデルのダウンロードが終わったら

## 重要なお知らせ

- **`Update.bat` での更新時にエラーが出る場合は `stable-diffusion-webui-reForge/venv/` を削除かリネームしてから `Update.bat` を再度実行してください。**

## 使い方（仮）

### 基本操作

- EasyReforge インストール先にある `Reforge.bat` で起動します。
	- 右側の `Generate` ボタンで画像を生成します。
		- 画像は `OutputReforge\txt2img-images` に保存されます。
			- `InfiniteImageBrowsing.bat` で生成した画像を確認できます。
	- プロンプト欄に入力するタグは [Danbooru](https://danbooru.donmai.us/) の左上にある `Search` 欄で、**日本語で検索して調べます** 。
	- `Generate` ボタン下のスタイル設定欄で `DMD2[4]: LCM, SGM Uniform 📋↙` を選択して `📋` と `↙` で基本的な設定を適用できます。
		- NSFW なら `safe` の代わりに `explicit` を適用します。
	- プロンプト入力欄下の `TIPO` を開いて `Enabled` を有効にすると、入力済みのプロンプトから関連するプロンプトを追加して生成します（NSFW で特に強力です）。
- **`Update.bat` で EasyReforge を更新します。**
- **起動時の設定状態は `Settings` の左下にある `Other` - `Defaults` で変更できます。**
	- `View changes` で変更内容を確認して、`Apply` で保存します。
	- 設定がよくわからなくなったら `stable-diffusion-webui-reForge/` にある `config.json`, `ui-config.json`, `styles.csv` を退避してから `EasyReforge.bat` を実行すると、初期状態にリセットします。
- UI の日本語併記を止めるには `Settings` にある `Bilingual Localization` の `Localization file` を `None` にして、`Apply settings` と `Reload UI` をしてください。

### 追加データのダウンロード

- `Settings` の左上 `Search...` 欄に `api` と入力すると `[Wiki] API key for authenticating with Civitai.` の設定が表示されます。  
	- [Wiki](https://github.com/zixaphir/Stable-Diffusion-Webui-Civitai-Helper/wiki/Civitai-API-Key) のリンク先をブラウザで翻訳して、内容にそって API Key を取得して、この設定欄にコピペしてから上の `Apply settings` で保存します。
- Civitai キーを設定したら `NoobAiEpsilonPred_StandardModels.bat` でモデルなどを一式ダウンロードします。
	- モデルのダウンロードが不要な場合は `NoobAiEpsilonPred_Standard.bat` を実行します。
- 追加データをダウンロードするとキャラやスタイルのワイルドカードが使えます。
	- `__NsfwPony/char__`: キャラワイルドカード
	- `__Booru1girl__`: 女性のみキャラワイルドカード
	- `__MixedStyle__`: 混合スタイルワイルドカード
	- `<lora:NoobEStylesDump:1> __NoobEStylesDump__`: スタイル LoRA とトリガーワイルドカード。V-Pred なら NoobE を NoobV にします。
	- `<lora:NoobEStylesCollection:1> __NoobStylesCollection__`: スタイル LoRA とトリガーワイルドカード。V-Pred なら NoobE を NoobV にします。

### 他の環境とのリソース共有

- モデルや LoRA は `Model/` 以下に保存します。
- 各サブフォルダの `LinkInput.bat` と `LinkOutput.bat` でモデルや LoRA を共有できます。
  - EasyReforge から他の環境のモデルや LoRA を参照したい場合は、`LinkInput.bat` を実行してください。
  - EasyReforge のモデルや LoRA を他の環境から参照したい場合は、`LinkOutput.bat` を実行してください。

### V-Prediction を試す

**NoobAI の V-Prediction 版は開発中です。**  
**現時点では V-Prediction & ZTSNR に対応した高速化 LoRA も存在しないため、強引な対応により品質が落ちています（が、その代わりに 3060 で FullHD を 15秒で生成できます）。**

[追加データのダウンロード](#追加データのダウンロード) で Civitai キーを設定してから、`Download/` にある `NoobAiVPred_StandardModels.bat` で V-Pred のモデルや LoRA をダウンロードします。


1. 左下にある `Advanced Model Sampling for reForge` を開いて `Enable Advanced Model Sampling` を有効にします。
	- V-Pred や ZTSNR 自動判定機能は派生モデルで正常に動作しない場合があるようですのでご注意ください。
1. `DMD2[4+]: Euler a CFG++, Beta 📋↙` を選択して、`📋` と `↙` で適用します。
	- モデルによっては `DMD2[4]: LCM, SGM Uniform 📋↙` の設定のままでも生成できます。
2. `__Booru1girl__ official logo, upper body` や `__NsfwPony/char__ official logo, upper body` で生成すると、ロゴなどで学習精度の高さを確認できます。

E-Pred に戻すときも同様です。

1. `DMD2[4]: LCM, SGM Uniform 📋↙` を選択して、`📋` と `↙` で適用します。
1. 左下にある `Advanced Model Sampling for reForge` を開いて `Enable Advanced Model Sampling` を無効にします。


## トラブルシューティング（仮）

- 初回の画像生成では問題がないが 2枚目以降で Runtime Error が発生する場合
	- `Reforge_ArgSample_CudaMemOpts.bat` で起動するとエラーが発生しない場合があります。
	- 画面左下の `Never OOM Integrated` で `Enable VRAM Management` を有効にし、`Choose how VRAM is managed` を `Disabled` や他の値に変更するとエラーが発生しない場合があります。
- `Update.bat` の更新でエラーが発生する場合
	- `stable-diffusion-webui-reForge/venv/` を削除かリネームしてから `Update.bat` を実行してください。

## 最近の更新

### 2024/11/17

- スタイルの運用を変更しました。
- UI の日本語併記を有効にしました。
	- UI の日本語併記を止めるには `Settings` にある `Bilingual Localization` の `Localization file` を `None` にして、`Apply settings` と `Reload UI` をしてください。
- 拡張機能の [Sigmas merge](https://github.com/Panchovix/reForge-Sigmas_merge) を追加しました。
- 画像の出力先フォルダを `Output/Reforge` から `OutputReforge` に変更しました。
	- 古い `Output/` は不要ですので削除してください。

### 2024/11/16

- サンプル画像を `Samples/` に含めます。  
**サンプル画像を `PNG Info` の `Send to txt2img` で読み込んだ際には、スタイル欄が空欄であることを確認してください。**  
ADetailerやAdvanced Model Sampling for reForgeの設定が、`Send to txt2img` では有効にならない点もご注意ください。
- 直近の [Forge Couple の更新](https://github.com/Haoming02/sd-forge-couple/commit/3925bc756e6bb221ee2b6326aea1594d40519953) でエラーが発生していたため巻き戻しました。
- バッチ生成時に同一シードになっていた問題を修正しました。
- HarmoniqMix_v10 のパス変更に対応し、HarmoniqMixSpo_v10 を追加しました。
- NoobV に [PersonalMergeVLow_v05](https://civitai.com/models/835655?modelVersionId=1064266) と [PersonalMergeVNormal_v05](https://civitai.com/models/835655?modelVersionId=1065716)を追加しました。  
**Low は高速化 LoRA の dmd2XL は不要です。** 生成情報付きサンプル  
![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/NoobV/NoobVPersonalMergeV_v05_0.webp)
- NoobE に [PVCStyleModelMovable_v10](https://civitai.com/models/338712?modelVersionId=1026901) を追加しました。生成情報付きサンプル  
![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/NoobE_Unique/PVCStyleModelMovable_v10_0.webp)
- 上記サンプルで意図的に入力したプロンプトは `santa costume, fashion magazine cover, night, snow` のみで、あとはワイルドカードと TIPO 補完です。

## ライセンス

このリポジトリの内容は [MIT License](./LICENSE.txt) です。
