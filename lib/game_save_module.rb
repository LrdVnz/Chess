# frozen_string_literal: true

require 'json'
require 'colorize'

# module for the methods regarding saving, loading the save files
module SaveGame
  def save
    puts 'Choose the name of the save file'
    save_name = gets.chomp
    json = { 'board' => @board, 'turns' => @turns,
             'winner' => @winner,
             'current_player' => @current_player,
             'p1' => @p1, 'p2' => @p2 }.to_json
    File.open(@saves_path + save_name, 'w') { |f| f << json }
  end

  def load
    puts 'Choose what save to load :'
    Dir.entries(@saves_path).each { |file| puts "#{file}\n" }
    save_name = gets.chomp
    save = File.read(@saves_path + save_name)
    data = JSON.parse(save)
    load_data(data)
  end

  def load_data(data)
    @current_player = data['current_player']
    @turns = data['turns']
    @winner = data['winner']
    @board = data['board']
    @p1 = data['p1']
    @p2 = data['p2']
  end

  def ask_load
    puts 'Do you want to load a game or start a new one ? (load/new)'
    answer = gets.chomp.downcase
    load if answer == 'load'
  end

  def ask_save
    puts 'Do you want to save the game ? (yes/ no or press enter)'.blue
    answer = gets.chomp.downcase
    return nil unless answer == 'yes'

    save
    puts 'Exit the game ? (yes/no)'
    response = gets.chomp.downcase
    exit if response == 'yes'
  end
end
