class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @contents = [
    # コメントアウトしているのは機能拡張の際に使用できる記述を残しておきます。
    # {name:"マイページ",path: "/users/#{@user.id}",verb: "GET"},
    # {name: "お知らせ", path:"#", verb: "GET"},
    # {name: "やることリスト", path:"#", verb: "GET"},
    # {name: "いいね！一覧", path:"#", verb: "GET"},
    {name: "出品する", path:"#", pattern: "GET"},
    # {name: "下書き一覧", path:"#", verb: "GET"},
    {name: "出品した商品-出品中", path:"#", verb: "GET"},
    # {name: "出品した商品-取引中", path:"#", verb: "GET"},
    {name: "出品した商品-売却済み", path:"#", verb: "GET"},
    # {name: "購入した商品-取引中", path:"#", verb: "GET"},
    {name: "購入した商品-過去の取引", path:"#", verb: "GET"},
    # {name: "ニュース一覧", path:"#", verb: "GET"},
    # {name: "評価一覧", path:"#", verb: "GET"},
    # {name: "ガイド", path:"#", verb: "GET"},
    # {name: "お問い合わせ", path:"#", verb: "GET"}
  ]
    # @furimapays = [
    # {name:"売上・振込申請",path: "#",verb: "GET"},
    # {name:"ポイント",path: "#",verb: "GET"}]
    @settings = [
    # {name:"プロフィール",path: "#",verb: "GET"},
    # {name:"発送元・お届け先住所変更",path: "#",verb: "GET"},
    {name:"クレジットカード登録",path: "#",verb: "GET"},
    # {name:"メール/パスワード",path: "#",verb: "GET"},
    # {name:"本人情報",path: "#",verb: "GET"},
    # {name:"電話番号の確認",path: "#",verb: "GET"},
    {name:"ログアウト",path: "#",verb: "DELETE"}
  ]
  end



end
