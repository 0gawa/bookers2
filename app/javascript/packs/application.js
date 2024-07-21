// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application" 
import '@fortawesome/fontawesome-free/js/all'
import "../stylesheets/side_bar"
import Raty from "../raty"

window.raty = function(elem,opt) {
  var raty =  new Raty(elem,opt)
  raty.init();
  return raty;
};

Rails.start()
Turbolinks.start()
ActiveStorage.start()

jQuery(document).on("turbolinks:load", function() {
  $('#user_postal_code').jpostal({
    postcode : [
      // 取得する郵便番号のテキストボックスをidで指定
      '#user_postal_code'
    ],
    address: {
      // %3 => 都道府県、 %4 => 市区町村 %5 => 町域 %6 => 番地 %7 => 名称
      // それぞれを表示するコントロールをidで指定
      "#user_address"  : "%3%4%5%6%7"
    }
  });
});