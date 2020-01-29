crumb :root do
  link "Home", root_path
end

# マイページ
crumb :mypages do
  link "マイページ", mypage_path
end

# ビューページを実装したらコメントアウトを外します
# # プロフィール
# crumb :profile do
#   link "プロフィール", edit_user_path
#   parent :mypage
# end

# 商品詳細ページ
# カテゴリやコントローラの設定が完了していないためfindでidを指定して表示できるようにしています
crumb :item do |item|
  link "#{item.name}", item_path(item)
  parent :root
end