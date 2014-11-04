require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  class AwesomeRockFilter
    AWESOME_ARTISTS = %w(Cooh Headhunterz)

    def call(track)
      AWESOME_ARTISTS.include? track.artist
    end
  end

  def setup
    @track = Track.new("High Rankin", "Horrorcane", "no idea", "dnb")
    @track1 = Track.new("Cooh", "300", "no idea", "dnb")
    @track2 = Track.new("Headhunterz", "dragonborn", "no idea", "hardstyle")
    @playlist = Playlist.new(@track, @track1, @track2)

  end

  def test_find
    assert_equal 2,
      @playlist.find { |track| track.genre == 'dnb' }.tracks.length
  end

  def test_find_by
    assert_equal 2,
      @playlist.find_by(AwesomeRockFilter.new).tracks.length
  end
end
