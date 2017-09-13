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
    array.each do |session| #session_hash = {:game => game_instance, players => [array of player instaces]}
      gqrows = GamingQueue.where(game_id: session.session_hash[:game].id)
      new_player = gqrows.map do |row|
        User.find(row.user_id)
      end.find do |user|  #Will only select first user
        user.in_session == false
      end
      if new_player
        session.add_player(new_player)
      end
    end
  end

  def place_users()
    self.place_uniq_users()
    return unless players_left?
    self.fill_to_min_1
    return unless players_left?
    self.fill_to_min_2
    return unless players_left?
    self.create_and_place_other_sessions

    self.fill_games
    #next function
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
    self.get_remaining_available_users.size == 0 ? false : true
  end

  def return_uniq_gq_game_id()
    GamingQueue.select(:game_id).distinct.map do |gqrow|
      gqrow.game_id
    end.sort
  end

  def return_active_sessions_game_ids()
    Session.all.map do |session|
        session.session_hash[:game].id
    end.sort
  end

  # def return_remaing_game_ids()
  #   gq_ids = return_uniq_gq_game_id
  #   sg_ids = return_active_sessions_game_ids
  #   gq_ids - sg_ids
  #   # gq_ids.reject! do |gq_id|
  #   #   sg_ids.any? do |sg_id|
  #   #     gq_id == sg_id
  #   #   end
  #   # end
  # end

  def get_remaining_available_users
    GamingQueue.select(:user_id).distinct.map do |gqrow|
      User.find(gqrow.user_id)
    end.select do |user|
      user.in_session == false
    end
  end

  def return_potential_game_interest_count_as_hash
    game_choices = []
    self.get_remaining_available_users.each do |user|
      GamingQueue.where(user_id: user.id).each do |gq_row|
        game_choices << gq_row.game_id
      end
    end
    interest_hash = Hash.new(0)
    to_hash = game_choices - self.return_active_sessions_game_ids
    to_hash.each do |game|
      interest_hash[game] += 1
    end
    interest_hash
  end

  def get_largest_remaining_as_array
    hash = return_potential_game_interest_count_as_hash
    # if hash.size <= 0
    #   binding.pry
    # end
    hash.max_by{|k,v| v}
  end

  def get_largest_remaining_game_as_instance
    if array = self.get_largest_remaining_as_array
      Game.find(array[0])
    else
      nil
    end
  end

  def return_remaining_users_for_game(game_id)
    self.get_remaining_available_users.select do |user|
      GamingQueue.where(user_id:user.id).any? do |gq_row|
        gq_row.game_id == game_id
      end
    end
  end

  def largest_remaining_has_min?
    get_largest_remaining_game_as_instance.min <= get_largest_remaining_as_array[1] ? true : false
  end

  def create_and_place_other_sessions
    largest_remaining = get_largest_remaining_game_as_instance
    until largest_remaining == nil || !self.players_left? || !self.largest_remaining_has_min?
      new_sesh = Session.new({game:largest_remaining})
      until new_sesh.has_min?
        new_sesh.add_player(return_remaining_users_for_game(largest_remaining.id).sample)
      end
      largest_remaining = get_largest_remaining_game_as_instance
    end
  end



end
