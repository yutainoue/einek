開発計画表
=================
##タイトル
###『オケ宣伝』
---------
##概要
オーケストラの広報担当者が抱える課題
2. 本番の集客を上げたい
1. 広報活動で自分の演奏時間を削られたくない
この二点を解決するため、
オーケストラの主要広報活動である「挟み込み」を効率化する。
---------
##挟み込みとは
他団体の演奏会で配布するパンフレットに
自身のチラシを挟み込んでお客さんに配布してもらう広報活動。
アマチュアオーケストラではポピュラーな手法。

自身のオーケストラ経験において、学生オケ・社会人オケ・企画オケ問わず
どのアマチュア楽団も確実に行っている。
---------
##挟み込み活動の流れ
#活動の流れ#
6. 挟み込みを依頼する演奏会を検索
5. 楽団サイトからメール依頼
4. 詳細情報の返信を受ける（基本的には断られない）
 9. 挟み込み作業を行う時間
 9. 持参するチラシ枚数
 9. お手伝いに来てほしい人数（1~2人）
 9. （チラシの郵送が可能か）
※交渉決裂要因は、お手伝いに行ける人員が確保できるかである。
3. 挟み込みのお手伝い人員の確保
2. 先方に返信して契約完了
1. 当日、演奏会会場へお伺いして1ｈほどの挟み込み作業を行い、完了。
---------
##挟み込みの効果
#メリット
3. アマチュアオーケストラに興味のあるターゲットに直接配布できる。
2. 一度の挟み込み1,000枚前後配れる
1. 無料で配布できる（挟み込み作業をお手伝いする労働力が対価）

#デメリット
6. チラシは予め印刷しておく必要がある
→ただし、団員配布用や周辺広報用に１〜２万部くらいチラシを刷っておくのが
オケ的には普通なので、あまり問題ではない。
ただし、運搬は重くてしんどい。
5. 挟み込み作業に派遣する労働力（団員）を確保するのがめんどくさい
→練習ごとに広報したりするが、挟み込み作業は移動も含めると
午前半日潰れる作業なので皆嫌がる。
4. 挟み込み先を探しにくい！【重要】
挟み込みを依頼する演奏会を探すとき、
Freude（フロイデ、アマチュアオーケストラ演奏会情報サイト）などで
本番前数ヶ月の演奏会をリストアップするが、ソートは開催日程のため、
演奏するホール近隣へ集中的にチラシを撒くのは難しい。
	 オケ専＜http://okesen.snacle.jp/concert＞には地域ソート機能もあるため、
機能が多いのが気になるが使いこなせば手動でリストアップできなくはない。
3. リストアップは手動
リストアップした表を作るためには、広報担当者がネットサーフィンして
楽団ページから演奏会情報・連絡先などコピーして表にする必要がある
2. 挟み込み一件決まるごとにいちいちチラシ持ってきて、
人員に渡してがめんどい、しんどい。
チラシ重いし。。。
1. ていうか計画すんの自体が超めんどい。
連絡する相手が多すぎる（他団体、団員、チラシ業者、全体広報、スケジュール管理）
---------
##現状への不満点
*そもそも何故リストアップする手間をかけなければいけないのか？
 HP自体がそのままリストアップされていた表であれば、
 この手間は無くせるのでは。

*システム側で自動的に広報スケジュール立てられないか？
 本番日程と場所登録したら、
 手前３ヶ月分の近隣演奏会をリストアップ表示するなど。

*挟み込みに派遣する人員の確保も面倒。
 広報スケジュールに合わせて伝助みたいな出欠管理システムを
 生成してくれれば、それを団内メーリングリストで送るだけで済むのでは。
---------
##開発計画
#0.step
web(Freude)から演奏会情報を引っ張り、homeに表示する。

#1.step
   「３ヶ月分」のアマチュアオーケストラ演奏会がトップページですぐ見れる。
サイト開いたらもう見れる。まあお手軽。
表示項目
・楽団名
・演奏会日
・ホール名
・所在地（区、市単位まで）
・連絡先へのリンク
→アドレスを載せているサイトと、独自に入力フォームを持っている楽団に別れるため。
→できればお問い合わせページに直接飛ばしたい。
↓メリット↓
広報担当者はとりあえず今から挟み込みに行ける楽団を一発把握できるため、
ネットサーフィンのタイムロスを削減、練習できる！
しかし、効果のあるシーンが限定される（本番3ヶ月前に挟み込み計画を立てるシーン専門）

#2.step
   自分の演奏会日程・開催ホール名を入力すると、
本番から逆算3ヶ月の演奏会を、開催ホールの近場優先でリストアップした表にしてくれる。
また、何らかの形でその結果を残せる。
（ログイン機能により検索履歴を残すor excel形式などで出力）
↓メリット↓
広報担当者は挟み込みの計画を考えなくて済む。ストレス削減！
かなり前の段階から計画建てられる。

#3.step
   作成したリストを伝助のようなスケジュール管理システムと連携して、
挟み込み人員を募れるようにする。
↓メリット↓
広報担当者はこれにより、団員へこのリストURLを送るだけで人員募集をすませられる
ようになり、広報作業工数の削減
