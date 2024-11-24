# EasyReforge

[reForge](https://github.com/Panchovix/stable-diffusion-webui-reForge) でお手軽に高速画像生成する EasyReforge です。  
[NoobAi](https://civitai.com/models/833294) の Epsilon-Prediction 版 ( **NoobE** ) と V-Prediction 版 ( **NoobV** ) を主に扱います。

- ワンクリックインストール
- Geforce RTX 3060 VRAM 12GB で FullHD を 10秒で生成するプリセット
- 便利な拡張機能一式を組み込み
- Civitai キー設定でモデル・LoRA・Wildcard・ADetailer モデルなどリソース一式をダウンロード

わからないことや不具合や要望がありましたら、 [@Zuntan03](https://x.com/Zuntan03) や [Issues](https://github.com/Zuntan03/EasyReforge/issues) にお知らせください。

## インストール方法

1.  [EasyReforgeInstaller.bat](https://github.com/Zuntan03/EasyReforge/raw/main/EasyReforge/EasyReforgeInstaller.bat?ver=0) を右クリックから保存します。
	- NVIDIA GPU の Windows PC、20GB 以上の空きストレージ、PC の管理者権限、アバストなどの Windows Diffender でないウィルスチェック無効化、VPN の無効化が必要です。
2. `C:/EasyReforge/` などの浅いパスのインストール先の空フォルダで、`EasyReforgeInstaller.bat` をダブルクリックして実行します。
	- **`WindowsによってPCが保護されました` と表示されたら、`詳細表示` から `実行` します。**
3. `動作に必要なモデルなどをダウンロードします。よろしいですか？ [y/n]（空欄なら y）` で `Enter` します。
4. インストールが問題なく終了したら [使い方](https://github.com/Zuntan03/EasyReforge/#使い方) へ。

**インストールで問題が発生したら『[インストールのトラブルシューティング](https://github.com/Zuntan03/EasyReforge/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%AE%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)』へ。**

## 使い方

![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/Reforge_00_Basic.webp)

![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/Tipo.webp)

|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/NoobV/TipoGrid0_4K.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/NoobV/TipoGrid1_4K.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/NoobV/TipoGrid2_4K.webp)|
|:-:|:-:|:-:|

### 基本操作

- EasyReforge インストール先にある `Reforge.bat` で起動します。
	- 右側の `Generate` ボタンで画像を生成します。
		- 画像は `OutputReforge\txt2img-images` に保存されます。
			- `InfiniteImageBrowsing.bat` で生成した画像を確認できます。
	- プロンプト欄に入力するタグは [Danbooru](https://danbooru.donmai.us/) の左上にある `Search` 欄で、**日本語で検索して調べます** 。
	- `Generate` ボタン下のスタイル設定欄で `DMD2[4]: LCM, SGM Uniform 📋↙` を選択して `📋` と `↙` で基本的な設定を適用できます。
		- **Latent 系 Hires. fix x1.5 の利用が前提のプリセットです。**
		- プロンプト末尾の safe は TIPO 用のレーティング指定です。  
		TIPO を利用しない場合は削除してください（金庫が生成される場合があります）。
	- プロンプト入力欄下の `TIPO` を開いて `Enabled` を有効にすると、入力済みのプロンプトから関連するプロンプトを追加して生成します（NSFW で特に強力です）。
		- 評価の高い NSFW を試すには `safe` を `explicit` に書き換えます。
	- 画像生成で問題が発生したら『[画像生成のトラブルシューティング](https://github.com/Zuntan03/EasyReforge/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0#%E7%94%BB%E5%83%8F%E7%94%9F%E6%88%90%E3%81%AE%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)』へ。
- **起動時の設定状態は `Settings` の左下にある `Other` - `Defaults` で変更できます。**
	- `View changes` で変更内容を確認して、`Apply` で保存します。
	- 設定がよくわからなくなったら `stable-diffusion-webui-reForge/` にある `config.json`, `ui-config.json`, `styles.csv` を退避してから `EasyReforge.bat` を実行すると、初期状態にリセットします。
- VRAM の少ない GPU では画面左下の `Never OOM Integrated` を有効にして、`Low VRAM` などを指定すると動作が快適になる可能性があります。
- UI の日本語併記を止めるには `Settings` にある `Bilingual Localization` の `Localization file` を `None` にして、`Apply settings` と `Reload UI` をしてください。
- 起動時にコマンドラインオプションを指定したい場合は `Reforge_ArgSample_DarkTheme.bat` をコピーして、ファイル内の `--theme dark` を書き換えます。
- **`Update.bat` で EasyReforge を更新します。**
	- 更新で問題が発生したら『[更新のトラブルシューティング](https://github.com/Zuntan03/EasyReforge/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0#%E6%9B%B4%E6%96%B0%E3%81%AE%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)』へ。

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
- `Download/` 直下の `bat` では追加データを一式ダウンロードできます。
	- `NoobAiEpsilonPred`, `NoobAiVPred`: [NoobAi](https://civitai.com/models/833294) の Epsilon-Prediction 版、V-Prediction 版の関連ファイルをダウンロードします。最初は扱いが簡単な `NoobAiEpsilonPred` がオススメです。
	- `Minimum`: 画像生成ができる最低限の関連ファイルをダウンロードします。`Minimum` のみ、下記の Civitai キー設定をしなくてもダウンロードできます。
	- `Standard`: `Minimum` に加えて、モデル以外の標準的な関連ファイルをダウンロードします。LoRA や ADetailer 検出モデルや Wildcard など、容量に対して効果が大きいモノが多いため、Civitai キーを登録してのダウンロードを推奨します。
	- `StandardModels`: `Standard` に加えて、合計 100GB 以下の定番オススメモデルをダウンロードします。
	- `All`: すべての関連ファイルをダウンロードします。
	- サブフォルダの `bat` で個別のダウンロードもできます。
	- モデルや LoRA は日々新しいモノが公開されますので、[Civitai](https://civitai.com/) で気になったモノを `Civitai Helper` でダウンロードしたり、`Civitai Helper Browser` で直接ダウンロードしてください（Civitai キー設定が必要）。

### 他の環境とのリソース共有

- モデルや LoRA は `Model/` 以下に保存します。
- 各サブフォルダの `LinkInput.bat` と `LinkOutput.bat` でモデルや LoRA を共有できます。
  - EasyReforge から他の環境のモデルや LoRA を参照したい場合は、`LinkInput.bat` を実行してください。
  - EasyReforge のモデルや LoRA を他の環境から参照したい場合は、`LinkOutput.bat` を実行してください。

### V-Prediction を試す

**NoobAI の V-Prediction 版は開発中です。**  
**現時点では V-Prediction & ZTSNR に対応した高速化 LoRA も存在しないため、強引な対応により品質が落ちています（が、その代わりに 3060 で FullHD を 10秒で生成できます）。**

[追加データのダウンロード](https://github.com/Zuntan03/EasyReforge/#追加データのダウンロード) で Civitai キーを設定してから、`Download/` にある `NoobAiVPred_StandardModels.bat` で V-Pred のモデルや LoRA をダウンロードします。

1. 左下にある `Advanced Model Sampling for reForge` を開いて `Enable Advanced Model Sampling` を有効にします。
	- V-Pred や ZTSNR 自動判定機能は派生モデルで正常に動作しない場合があるようですのでご注意ください。
1. `DMD2[4+]: Euler a CFG++, Beta 📋↙` を選択して、`📋` と `↙` で適用します。
	- モデルによっては `DMD2[4]: LCM, SGM Uniform 📋↙` の設定のままでも生成できます。
2. `__Booru1girl__ official logo, upper body` や `__NsfwPony/char__ official logo, upper body` で生成すると、ロゴなどで学習精度の高さを確認できます。

E-Pred に戻すときも同様です。

1. `DMD2[4]: LCM, SGM Uniform 📋↙` を選択して、`📋` と `↙` で適用します。
1. 左下にある `Advanced Model Sampling for reForge` を開いて `Enable Advanced Model Sampling` を無効にします。

## 最近の更新

### 2024/11/24

- [追加データのダウンロード](https://github.com/Zuntan03/EasyReforge/#追加データのダウンロード) に `Download/` 直下にある `bat` ファイルの説明を追加しました。

### 2024/11/23

- [mokyu2106/iroiro_data](https://huggingface.co/datasets/mokyu2106/iroiro_data) の Noob で使える LECO をダウンロードする `Download/Lora/Noob_Leco/MokyuLeco.bat` を追加しました。
	- NoobE と NoobV の両方で使えます。
	- Erase LECO ですので、LoRA ファイル名先頭のトリガーワードをプロンプトに追加し、LoRA 定義では `-10` ~ `-20` といった大きめの強度を指定します。
- デフォルトで CUDA メモリ最適化オプションを有効にして、`Reforge_CudaMemOpts.bat` を削除しました。
	- CUDA メモリ最適化オプションで問題が発生する場合は `Reforge_NoOptions.bat` をご利用ください。

### 2024/11/22

- [HarmoniqMixSpo_v21](https://huggingface.co/hybskgks28275/HarmoniqMix_vPred_v2.x),[illusobV05_v11](https://civitai.com/models/916130?modelVersionId=1069801) のダウンロードに対応しました。

### 2024/11/21

- [HarmoniqMixSpo_v20](https://huggingface.co/hybskgks28275/HarmoniqMix_vPred_v2.x), [HikariNoob_v065](https://huggingface.co/RedRayz/hikari_noob_0.6.5), [ObsessionV_v01](https://civitai.com/models/820208?modelVersionId=1080860) のダウンロードに対応しました。

### 2024/11/20

- ドキュメントに『[トラブルシューティング](https://github.com/Zuntan03/EasyReforge/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)』を追加しました。
- 『[ずっと遊べる TIPO のススメ](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/Tipo.webp)』を公開しました。

### 2024/11/19

- Civitai からの DL ができない不具合を修正しました。
- プリセットに `DMD2[4]: DPM++ 2S a, SGM Uniform 📋↙` を追加しました。
- [HarmoniqMixSpoEx_v11](https://huggingface.co/hybskgks28275/checkpoint) のダウンロードに対応しました。
- ダークテーマを設定する起動オプションサンプルの `Reforge_ArgSample_DarkTheme.bat` を追加しました。

### 2024/11/18

- [NoobAiVPredIterComp_v06](https://civitai.com/models/935739?modelVersionId=1071682), [copycatNoobV_v06](https://civitai.com/models/894218?modelVersionId=1073042) のダウンロードに対応しました。
- [sd-webui-ar](https://github.com/alemelis/sd-webui-ar) を [sd-webui-ar-plusplus](https://github.com/altoiddealer/--sd-webui-ar-plusplus) に変更しました。
- [sd-webui-lora-block-weight](https://github.com/hako-mikan/sd-webui-lora-block-weight) を [sd-webui-lora-block-weight-reforge](https://github.com/Panchovix/sd-webui-lora-block-weight-reforge) に変更しました。

[NoobAiVPred_v06](https://civitai.com/models/833294?modelVersionId=1070239) と [HarmoniqMixSpo_v11](https://huggingface.co/hybskgks28275/checkpoint) のサンプラ・スケジューラ例

|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/log/2411/NoobAiVPred_v06-Sampler1_2.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/log/2411/HarmoniqMixSpo_v11-Samper1_2.webp)|
|:-:|:-:|
|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/log/2411/NoobAiVPred_v06-Sampler0_2.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/log/2411/HarmoniqMixSpo_v11-Samper0_2.webp)|


### 2024/11/17

- [NoobAiVPred_v06](https://civitai.com/models/833294?modelVersionId=1070239), [HarmoniqMixSpo_v11](https://huggingface.co/hybskgks28275/checkpoint) のダウンロードに対応しました。
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

### 2024/11/15

- 公開

## 参考画像

柔軟なスタイル選択

![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/NoobV/NoobVMixStyle.webp)

|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/NoobE/NoobEMixStyle0.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/NoobE/NoobEMixStyle1.webp)|
|:-:|:-:|

## ドキュメント

- [トラブルシューティング](https://github.com/Zuntan03/EasyReforge/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)

## ライセンス

このリポジトリの内容は [MIT License](./LICENSE.txt) です。
