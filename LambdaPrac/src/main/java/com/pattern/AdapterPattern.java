package com.pattern;


interface MediaPlayer{
    void play(String audioType, String fileName);
}

class VlcPLayer{
    void playVlc(String fileName){
        System.out.println("Playing VLC files :"+fileName);
    }
}

class MediaAdapter implements MediaPlayer{

    VlcPLayer vlc = new VlcPLayer();


    @Override
    public void play(String audioType, String fileName) {
        if(audioType.equalsIgnoreCase("vlc")){
            vlc.playVlc(fileName);
        }else{
            System.out.println("Invalid media type for adapter: " + audioType);
        }
    }
}

class AudioPlayer implements MediaPlayer{

    MediaAdapter mediaAdapter;

    @Override
    public void play(String audioType, String fileName) {
        if(audioType.equalsIgnoreCase("mp3")){
            System.out.println("Playing MP3 :"+fileName);
        }else if(audioType.equalsIgnoreCase("vlc")){
            mediaAdapter = new MediaAdapter();
            mediaAdapter.play(audioType,fileName);
        }else{
            System.out.println("Unsupported file format : "+audioType);
        }
    }
}

public class AdapterPattern {
    public static void main(String[] args) {
        AudioPlayer audioPlayer = new AudioPlayer();

        audioPlayer.play("mp3", "song.mp3");
        audioPlayer.play("vlc", "movie.vlc");
        audioPlayer.play("mp4", "video.mp4");
    }
}
