class ProductsController < ApplicationController

  def index  # indexアクションを定義した
    @product = "これはコントローラーで定義したインスタンス変数を確認するための文字列です"
  end

end
