class SessionManager

  def initialize
    User.update_all(in_session: false)
  end

  def pull_data()
    GamingQueue.all
  end

  def sort_by_sessions()
    GamingQueue.group(:user_id).count
  end

  def place_uniq_users()
    sort_by_sessions.each do |user, num_sessions|
      if num_sessions == 1
        game_id = GamingQueue.find_by(user_id: user).game_id #game id is finding the us
        new_sesh = Session.find_or_create_by_game_id(game_id)
        new_sesh.add_player(User.find(user))
      end
    end
  end

  def min_minus(missing)
    Session.all.select do |session|
      session.players.count == (session.session_min - missing)
    end
  end

  def fill_to_min_1()
    array = min_minus(1)
    array.each do |session|     #session_hash = {:game => game_instance, players => [array of player instaces]}
      gqrows = GamingQueue.where(game_id: session.session_hash[:game].id)
      new_player = gqrows.map do |row|
        User.find(row.user_id)
      end.find do |user|
        user.in_session == false
      end
      if new_player
        session.add_player(new_player)
      end
    end
  end

  def place_users()
    self.place_uniq_users()
    self.fill_to_min_1
    # players_left?
    self.fill_to_min_2
    # players_left?
    self.fill_games
  end

  def fill_to_min_2
    array = min_minus(2)
    array.each do |session|
      gqrows = GamingQueue.where(game_id: session.session_hash[:game].id)
      possible_users = gqrows.map do |row|
        User.find(row.user_id)
      end.select do |user|
        user.in_session == false
      end
      if possible_users.size > 1
        session.add_player(possible_users.first)
        session.add_player(possible_users.second)
      end
    end
  end

  def fill_games
    Session.all.select do |sesh|
      sesh.has_min? && !sesh.has_max?
    end.each do |session|
      gqrows = GamingQueue.where(game_id: session.session_hash[:game].id)
      hopeful_players = gqrows.map do |row|
        User.find_by(id: row.user_id, in_session: false)
      end.compact
      hopeful_players.each do |player|
        session.add_player(player)
        break if session.players.size == session.session_max
      end
    end

  end

  def players_left?
    arr = User.where(in_session: false)
    arr.size == 0 ? false : true
  end


end
