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

|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/Reforge_00_Basic.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/Reforge_01_Tipo.webp)|
|:-:|:-:|
|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/Reforge_02_VPred.webp)||

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

## 最近の更新内容

**reForge の更新内容は [こちら](https://github.com/Panchovix/stable-diffusion-webui-reForge/commits/main) 。**

### 2025/01/13

- ['PuLIDMode' is not defined.](https://github.com/Panchovix/stable-diffusion-webui-reForge/issues/236) の不具合対処のため、reForge を 2025/01/10 バージョンに固定しました。
- `Hires CFG Scale` の追加に対応しました。デフォルト設定で崩れていた絵が修正されます。  
![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/log/2501/HiresCfg.webp)
- TIPO のモデルを `TIPO-200M-ft2-F16.gguf` に更新しました。

### 2024/12/03

- [HarmoniqMixSpoE_v10](https://huggingface.co/hybskgks28275/HarmoniqMix_ePred_v1.x), [ColourfulTart_v10](https://civitai.com/models/997743?modelVersionId=1118059) のダウンロードに対応しました。
- VAE の [XlVaeC_f2](https://civitai.com/models/152040?modelVersionId=719135), [AaaAnime_v15](https://civitai.com/models/888145?modelVersionId=1042046) のダウンロードに対応しました。
- ControlNet の `NoobE_LineartRealistic`, `NoobE_MangaLine`, `NoobE_Openpose_pre`, `NoobE_ScribbleHed`, `NoobE_ScribblePidinet`, `NoobE_SoftedgeHed` のダウンロードに対応しました。
	- `Download/All/ControlNet_NoobE.bat` でまとめてダウンロードできます。
- [TIPO](https://x.com/Zuntan03/status/1859018166770520479) でスポーツを指定するといろんな競技になるらしいので試してみました。
	- (sports ware, alternate costume, playing sports: 1.3) と競技名は未指定です。
	- 競技の偏りに対しては Ban tags で対処できます。
	- ついでにリアル系のモデルやプロンプトを、NoobE の新プリセットでお試しです。

|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/log/2412/sports_0_4K.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/log/2412/sports_1_4K.webp)|
|:-:|:-:|
|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/log/2412/sports_2_4K.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/log/2412/sports_3_4K.webp)|

### 2024/12/02

- EasyReforge で使用する reForge のブランチを `dev` から `main` に変更しました。
	- `dev` の ControlNet のマスクが効かない不具合を回避できますが、他の機能に問題がある可能性もあります。
	- `dev` にしたい場合は `Reforge/` にある `ReforgeSwitchDev.bat` で戻せます。  
	`main` にしたい場合は `ReforgeSwitchMain.bat` です。
- ControlNet の `NoobE_Canny`, `NoobE_DepthMidas_v11`, `NoobE_LineartAnime`, `NoobE_NormalMidas` を fp16 版に変更しました。

### 2024/12/01

- Windows の長いパス対応が無効だと、Huggingface からのバンドルダウンロードに失敗する場合があります。
	- `Download/Lora/Noob_Bundle/*.bat` によるダウンロードに失敗する場合は、Windows の管理者権限で `EasyTools/EnableLongPaths.bat` を実行してください。
- [NoobAiEpsilonPred_v11](https://huggingface.co/Laxhar/noobai-XL-1.1), [NonameMixL_v11](https://huggingface.co/Emanon14/NONAMEmix_v1), [NtrMix_v40](https://civitai.com/models/926443?modelVersionId=1061268), [WaiShuffleNoob_v10](https://civitai.com/models/989367?modelVersionId=1108388), [PornMasterPro_v02](https://civitai.com/models/80473?modelVersionId=1115553), [CatTower_v12](https://civitai.com/models/920709?modelVersionId=1108042), [susamixV_v31](https://civitai.com/models/944769?modelVersionId=1114026) のダウンロードに対応しました。
- 「NegPiP が効いてないかも？」の声を見かけたので確認しました。
	- 2列目で帽子がなく、3~4列目にあれば効果があります。
	- モデルなどによって効果にバラツキがあり、運が悪いと効果なしに見えちゃうかもですね。
	- V-Pred の方が効果が安定してる感があります。
	- 高速化 LoRA 利用環境での確認です。

|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/Noob/NegPipNoobE_4K.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/Noob/NegPipNoobV_4K.webp)|
|:-:|:-:|

![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/log/2412/NegPipUi.webp)

### 2024/11/30

- [NonameMix_v11](https://huggingface.co/Emanon14/NONAMEmix_v1) のダウンロードに対応しました。
- Tagger によるタグ付けに対応しました。
	- 新しい `WD EVA02-Large Tagger v3` や、e621 タグの `Z3D-E621-Convnext` も使えます。

![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/log/2411/Tagger.webp)

### 2024/11/29

- `NoobAiVPred_v065s` や派生モデルを高速化する [NoobV065sHyperDmd](https://huggingface.co/Zuntan/NoobHyperDmd) に対応しました。
	- `Advanced Model Sampling` を有効にして、NoobV 系モデルと `NoobV` プリセットでご利用ください。

|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/Reforge_02_VPred.webp)  |![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/NoobV/VpredZtsnr.webp)|
|:-:|:-:|
|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/NoobV/NoobV065s0_4K.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/NoobV/NoobV065s1_4K.webp)|

[過去の更新内容](https://github.com/Zuntan03/EasyReforge/wiki/%E9%81%8E%E5%8E%BB%E3%81%AE%E6%9B%B4%E6%96%B0%E5%86%85%E5%AE%B9)（参考画像もこちらにあります。）


## ドキュメント

- [トラブルシューティング](https://github.com/Zuntan03/EasyReforge/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)
- [過去の更新内容](https://github.com/Zuntan03/EasyReforge/wiki/%E9%81%8E%E5%8E%BB%E3%81%AE%E6%9B%B4%E6%96%B0%E5%86%85%E5%AE%B9)

## ライセンス

このリポジトリの内容は [MIT License](./LICENSE.txt) です。
