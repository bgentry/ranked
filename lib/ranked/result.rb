require "tzinfo"

module Ranked
  class Result < Sequel::Model

    def self.tz
      @tz ||= TZInfo::Timezone.get("America/Los_Angeles")
    end

    def loser
      @loser ||= Player[loser_id]
    end

    def winner
      @winner ||= Player[winner_id]
    end

    def winner_name
      winner.name
    end

    def loser_name
      loser.name
    end

    def opponent(player)
      [winner, loser].find { |p| p != player }
    end

    def result(player)
      { winner_id => "win", loser_id  => "loss" }[player.id]
    end

    def time
      self.tz.utc_to_local(at)
    end
  end
end
