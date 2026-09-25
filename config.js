// Supabase connection for the Nordic Cup 2027 desk.
// Find both values in Supabase: Project Settings -> API.
// The "anon public" key is safe to publish; the database rules in supabase/schema.sql
// make sure only logged-in volunteers can read or change data.
window.NORDIC_CUP_CONFIG = {
  supabaseUrl: "https://hifvdudlcjtawlebafau.supabase.co",
  supabaseAnonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhpZnZkdWRsY2p0YXdsZWJhZmF1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTAzMjk1NTIsImV4cCI6MjEwNTkwNTU1Mn0.845G7Ett87dQQbX5uP94tav8YDMYI23hBulnLuJyPTA"
};
