export interface Favorite {
    user_id: number;
    song_id: number;
  }
  export interface History extends Favorite {
    play_date: string;
  }