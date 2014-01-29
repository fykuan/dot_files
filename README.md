dot_files
=========

我的zsh + vim + tmux 等等等的環境設定

###螢幕截圖

#### ZSH
![Imgur](http://i.imgur.com/0heyRVl.png)

###安裝
#### Prerequirement
* vim (with Python support)
* zsh
* patch過的字型（沒patch過的沒有powerline使用的特殊符號）

#### 流程
1. 把repository clone回去

		git clone git@github.com:fykuan/dot_files.git
		
2. 執行install-env.sh，會把該拉回來的都拉回來

3. 執行modules/powerline/setup.py

		sudo modules/powerline/setup.py install
		
4. 重新登入

5. 執行vim，在vim內執行

		: BundleInstall