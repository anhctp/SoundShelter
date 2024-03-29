export interface Song {
  id: number;
  album_id: number;
  playlist_id: number;
  title: string;
  artist: string;
  audio_file_path: string;
  image_file_path: string;
  release_date: string;
  views: number;
}
export interface Album {
  id: number;
  artist: string;
  title: string;
  genre_id: number;
  release_date: string;
  image_file_path: string;
}
export interface Playlist {
  id: number;
  name: string;
  user_id: number;
  image_file_path: string;
}
