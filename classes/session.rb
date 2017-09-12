class Session


  attr_reader :session_hash


  ALL = []


  def initialize(session_hash = {})
    @session_hash = session_hash
    @session_hash[:players] = []
    ALL << self
  end

  def self.find_or_create_by_game_id(game_id)
    sesh = self.all.find do |session|
      session.session_hash[:game].id == game_id
    end
    if sesh == nil
      new_game = Game.find(game_id)
      sesh = Session.new({game: new_game })
    end
    sesh
  end

  def game()
    @session_hash[:game]
  end

  def players()
    @session_hash[:players]
  end

  def add_player(player)
    if (!self.has_max?) && (player.in_session == false)
      @session_hash[:players] << player
      player.in_session = true# if self.session_hash[:players].include?(player)
      player.update(in_session: true)
      # binding.pry
    end
  end


  def session_min()
      @session_hash[:game].min
  end

  def has_min?()
    self.session_min() <= self.players.size ? true : false
  end

  def session_max()
      @session_hash[:game].max
  end

  def has_max?()
    self.session_max() == self.players.size ? true : false
  end

  def self.all()
      ALL
  end

end
