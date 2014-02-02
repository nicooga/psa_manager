# encoding : utf-8

MoneyRails.configure do |config|

  config.default_currency = :ars
  config.amount_column = { prefix: '',
                           postfix: '_cents',
                           column_name: nil,
                           type: :integer,
                           present: true,
                           null: false,
                           default: 0 }
end
