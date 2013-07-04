require 'sinatra'
require 'nest_thermostat'

configure :production do
  puts "Production Mode"
end

configure :development do
  puts "Development Mode"
  enable :logging
end

def self.routing

  get '/' do
    'Welcome to Nester!'
  end

  get '/api/*/*/*' do |email, pass, action|
    logger.info "Your email is #{email} and your password is #{pass}, your action is #{action}"

    init_nest_connection(email, pass)

    action = actionsplitter(action)

    if action[0] == "temp"
      if action[1]
        output = temp(action[1])
      else
        output = temp
      end
    end

    if action[0] == "away"
      if action[1]
        output = away(action[1])
      else
        output = away
      end
    end

    output
  end

end

def actionsplitter(action)
  action.split("/")
end

def temp(command = "current")
  logger.info "Temp command = #{command}"

  output = @nest.current_temp

  logger.info "Output: #{output}"

  erb "Current temp: #{output}"
end

def away(command = "current")
  logger.info "Away comand = #{command}"

  if command == "current"

    current_status = @nest.away

    if current_status
      "You are currently set to away"
    else
      "You are currently set to Home"
    end

  elsif command == "false" || command == "true"
    
    @nest.away = true if command == "true"
    @nest.away = false if command == "false"

    current_status = @nest.away

    if current_status
      "You are now set to away"
    else
      "You are now set to Home"
    end
  end
end

def init_nest_connection(email, pass)
  @nest = NestThermostat::Nest.new({email: email, password: pass})
end

routing

