namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando DB...") {%x(rails db:drop)}
      show_spinner("Criando DB...") {%x(rails db:create)}
      show_spinner("Migrando DB...") {%x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
      
    else
      puts "Você não está em ambiente de desenvolvimento"
    end
  end

  desc "Cadastra as Moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando Moedas...") do
      coins = [
                { 
                  description: "Bitcoin",
                  acronym: "BTC",
                  url_image: "https://as1.ftcdn.net/v2/jpg/01/88/16/50/1000_F_188165041_C4LeZPJhrtGSy1hRRk0w77K4b2zA9nUB.jpg",
                  mining_type: MiningType.find_by(acronym: 'PoW')
                },
                {
                  description: "Ethereum",
                  acronym: "ETH",
                  url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSty0yMzrN_NesfLt2EjU4oYuyrQJ3iIJu0Zw&usqp=CAU",
                  mining_type: MiningType.all.sample
                },
                {
                  description: "Dash",
                  acronym: "DASH",
                  url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/131.png",
                  mining_type: MiningType.all.sample
                },
                {
                  description: "Iota",
                  acronym: "IOT",
                  url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSszIMhQ1SIBXf0FX6tLxDcxA0pXo9E5wyGyKZGXz2XUu92F2sibJ9LprpTp7mowTkpRdE&usqp=CAU",
                  mining_type: MiningType.all.sample
                },
                {
                  description: "ZCash",
                  acronym: "ZEC",
                  url_image: "https://play-lh.googleusercontent.com/ItuRy4nuOUVxxAXYtubq7xtI87VWB9jKhMBzC6_vJ21rKstU2sff3T3xP-U-ny1fFjMn=w240-h480",
                  mining_type: MiningType.all.sample
                }
              ]

      coins.each do |coin|
        Coin.create(coin)
      end
    end
  end

  desc "Cadastro os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]
  
      mining_types.each do |mining_types|
        MiningType.create(mining_types)
      end
    end
  end

  private
  
  def show_spinner(msg_start, msg_end = "Concluido!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")    
  end
end
