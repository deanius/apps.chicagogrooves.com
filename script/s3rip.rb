# TODO explain which vars need to be present
# bucket
# s3sh + connection

#bucket='nevergoback'
#folder='2013-01-20/'
#songs=['DevilsExpress.mp3', 'Speed.mp3']

songs.each do |song|
  this_song = folder+song
  open(song, 'w') do |file|
    S3Object.stream(this_song, bucket) do |chunk|
      file.write chunk
    end
  end
  mtime = Time.parse( S3Object.find( this_song, bucket ).about['last-modified'] )
  File.utime(mtime, mtime, song)
end


