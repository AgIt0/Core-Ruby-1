class Track
  attr_accessor :artist, :name, :album, :genre

  def initialize(*args)
    if args[0].instance_of? Hash
      self.artist = args[0].fetch(:artist)
      self.name = args[0].fetch(:name)
      self.album = args[0].fetch(:album)
      self.genre = args[0].fetch(:genre)
    else
      self.artist = args[0]
      self.name = args[1]
      self.album = args[2]
      self.genre = args[3]
    end
  end
end

class Playlist
  attr_accessor :tracks

  def self.from_yaml(path)
    # Your code goes here.
  end

  def initialize(*tracks)
    @tracks = tracks.flatten
  end

  def each
    @tracks.to_enum unless block_given?

    @tracks.each do |element|
      yield(element)
    end
  end

  def find(&block)
    # Filter the playlist by a block. Should return a new Playlist.
    Playlist.new(@tracks.select(&block))
  end

  def find_by(*filters)
    # Filter is any object that responds to the method #call. #call accepts one
    # argument, the track it should match or not match.
    #
    # Should return a new Playlist.

    tracks = [].tap do |tracks|
      filters.each do |filter|
        tracks << @tracks.select { |x| filter.call(x) }
      end
    end

    Playlist.new(*tracks.uniq)
  end

  def find_by_name(name)
    Playlist.new(find_by_helper(:name, name))
  end

  def find_by_artist(artist)
    Playlist.new(find_by_helper(:artist, artist))
  end

  def find_by_album(album)
    Playlist.new(find_by_helper(:album, album))
  end

  def find_by_genre(genre)
    Playlist.new(find_by_helper(:genre, genre))
  end

  def shuffle
    Playlist.new(@tracks.shuffle)
  end

  def random
    @tracks.sample
  end

  def to_s
    # It should return a nice tabular representation of all the tracks.
    # Checkout the String method for something that can help you with that.
  end

  def &(playlist)
    tracks = []
    playlist.each do |track|
      tracks << track if @tracks.include? track
    end

    Playlist.new(tracks)
  end

  def |(playlist)
    tracks = @tracks
    playlist.each { |track| tracks << track }

    Playlist.new(tracks.uniq)
  end

  def -(playlist)
    tracks = @tracks.dup

    playlist.each do |track|
      tracks = tracks.reject { |track1| track1 == track }
    end

    Playlist.new(tracks)
  end

  private

  def find_by_helper(type, value)
    tracks = [].tap do |tracks|
      tracks << @tracks.select { |track| track.public_send(type) == value }
    end
  end
end
