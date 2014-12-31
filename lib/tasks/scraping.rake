namespace :scraping do
  # descの記述は必須
  desc "2013-2014をスクレイピング"

  # :environment は モデルにアクセスするのに必須
  task :scrap => :environment do

    #最初にDBを初期化
    Concert.delete_all

    #2014,2015をスクレイピング
    start_year = 2013

    1.times do
      start_year = start_year + 1
      #一年間（12ヶ月）全てをスクレイピングしたい
      1.times do |x|
        month_now = x + 1
        #ｘを英語の月名に変換
        case month_now
        when 1 then
          month_name = 'jan'
        when 2 then
          month_name = 'feb'
        when 3 then
          month_name = 'mar'
        when 4 then
          month_name = 'apr'
        when 5 then
          month_name = 'may'
        when 6 then
          month_name = 'jun'
        when 7 then
          month_name = 'jul'
        when 8 then
          month_name = 'aug'
        when 9 then
          month_name = 'sep'
        when 10 then
          month_name = 'oct'
        when 11 then
          month_name = 'nov'
        when 12 then
          month_name = 'dec'
        end

        scrape_page = "http://www2s.biglobe.ne.jp/~jim/freude/calendar/#{start_year}#{month_name}.html".to_s

        agent = Mechanize.new

        begin
          page = agent.get(scrape_page)

          # その月ページがなかったらレスキュー
        rescue Mechanize::ResponseCodeError => ex
          case ex.response_code
          when "404"
            warn "#{ex.page.uri} is not found. skipping..."
            next
          when /\A5\d\d\Z/
            warn "server error on #{ex.page.uri}"
            break
          else
            warn "UNEXPECTED STATUS: #{ex.response_code} #{ex.page.uri}"
            break
          end
        end

        #ほんとはpage.links.countで回す
        page.links.count.times do |i|
          @concert = Concert.new
          page = agent.get(scrape_page)
          link = page.links[i]
          link_url   = link.href #.gsub("..", "http://www2s.biglobe.ne.jp/~jim/freude")

          begin
            page = agent.get(link_url)
            #エラーをレスキュー(あとでしっかりチェックしよ)
          rescue Mechanize::ResponseCodeError => ex
            case ex.response_code
            when "404"
              warn "#{ex.page.uri} is not found. skipping..."
              next
            when /\A5\d\d\Z/
              warn "server error on #{ex.page.uri}"
              break
            else
              warn "UNEXPECTED STATUS: #{ex.response_code} #{ex.page.uri}"
              break
            end
          end

          item = Array.new(10)

          #演奏会情報でなければnext,演奏会情報ページにしか無いリンク場所を参照している。
          if page.search('//tr[6]/td/center/a[2]').empty?
            next
          end

          # 演奏会タイトルの取得
          # [TODO] - ここもmain,subで二段表示
          main_title = ""
          main_title = page.search('//tr[1]/td/b/font').text.gsub("　", "").gsub("'", "’")
          sub_title = page.search('//tr[1]/td/p/b/font').text.gsub("　", "").gsub("'", "’")
          full_title = main_title #"#{main_title}【#{sub_title}】"
          if full_title.nil?
            @concert.name = "なし"
          else
            @concert.name = full_title
          end

          # 日時・場所・を取得
          # [TODO] - ここも配列で取得して、リスト表示にしたい
          page.search('//tr[3]/td/blockquote/p').each_with_index do |node, i|
            item[i] = node.text
          end

          program = item[0]
          if program.nil?
            @concert.program = "なし"
          else
            @concert.program = program
          end

          #場所情報をホール名のみに変更して取得
          item[1] = "読み込みエラー" if item[1].nil?

          stage_hull_name = item[1].to_s.gsub("\n場所： ", "")
          if stage_hull_name.empty?
            @concert.stage = 'なし'
          else
            @concert.stage = stage_hull_name
          end

          # 演奏曲目を連結表示
          content_all = []
          # [TODO] - indexいらなくね？
          page.search('//dd/b').each do |node|
            content_all.push(node.text.gsub("'", "’"))
          end
          if content_all.nil?
            @concert.content = "なし"
          else
            @concert.content = content_all
          end

          # お問い合わせ先を表示
          begin
            if page.search("//tr[3]/td/center/p[1]/a").blank?
              # if page.search("//tr[3]/td/center/a").blank?
                # info = ''
              # else
              info = page.search("//tr[3]/td/center/a").attribute("href").text
              # end
            else
              info = page.search("//tr[3]/td/center/p[1]/a").attribute("href").text
            end
          rescue
            info = ''
          end

          # リンク切れはエラーと一緒に扱う
          if info == 'http://'
            info = ''
          end

          @concert.information = info.to_s

          # 住所情報を表示
          hall_short_name = stage_hull_name.gsub(/ |大|小|シンフォニー|ホール|（/," " => "","大" => "","小" => "","中" => "" ,"シンフォニー" => "", "ホール" => "　", "（" => "　").split("　")

      #    @access = Access.new
      # [TODO] - べた書きだとうまく行くのに、変数で書くとnil???????
          hall_station = Access.where("hall_name like '%" + "#{hall_short_name[0]}" + "%'")

          hall_station.each do |this_hall_station|
            @concert.station = this_hall_station.station
          end

          @concert.stage = hall_short_name[0]

          #何時の演奏会か判断するためのカラム
          @concert.year = start_year
          @concert.month = month_now
          concert_day = program[11 + month_now,2].gsub("日","").to_i
          @concert.day = concert_day
          #セーブする
          @concert.save

        end
      end
    end
  end
end
