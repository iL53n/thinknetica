require_relative './manufacturer.rb'
require_relative './instance_counter.rb'
require_relative './validation.rb'
<<<<<<< HEAD
require_relative './accessors.rb'
=======
>>>>>>> 1e0905092aac27c087aa93f294c9e941b33ce845

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
<<<<<<< HEAD
  extend Accessors
=======
>>>>>>> 1e0905092aac27c087aa93f294c9e941b33ce845

  # Допустимый формат: три буквы или цифры, необязательный дефис, и еще 2 буквы или цифры.
  NUMBER_FORMAT = /^[a-zа-яё\d]{3}-?[a-zа-яё\d]{2}$/i.freeze

<<<<<<< HEAD
  attr_accessors_with_history :speed, :carriages, :route, :number, :type
=======
  attr_reader :speed,
              :carriages,
              :route,
              :number,
              :type
>>>>>>> 1e0905092aac27c087aa93f294c9e941b33ce845

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def speed_up(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    return unless speed.zero?

    @carriages << carriage if attachable_carriage?(carriage)
  end

  def remove_carriage
    return unless speed.zero?

    @carriages.pop
  end

  def assign_route(route)
    @route = route
    @current_station = 0
    current_station.add_train(self) # на станцию начальную[0] добавляем текущий объект
  end

  def forward
    return unless next_station

    current_station.send_train(self)
    next_station.add_train(self)
    @current_station += 1
  end

  def back
    return unless prev_station

    current_station.send_train(self)
    prev_station.add_train(self)
    @current_station -= 1
  end

  def current_station
    route.stations[@current_station] # возвращает станцию на позиции @current_station
  end

  def each_carriage
    @carriages.each { |carriage| yield(carriage) }
  end

  protected

  def prev_station
    route.stations[@current_station - 1] if @current_station.positive? # возвращает станцию на поз @current_station - 1
  end

  def next_station
    route.stations[@current_station + 1] # возвращает станцию на позиции @current_station + 1
  end
end
