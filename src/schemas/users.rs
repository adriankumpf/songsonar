use sqlx::FromRow;

#[derive(FromRow, Debug)]
pub struct User {
    pub spotify_id: String,
    pub playlist_id: Option<String>,
    pub access_token: String,
    pub refresh_token: String,
    pub weeks_in_playlist: Option<i16>,
    pub can_read_private_playlists: Option<bool>,
}