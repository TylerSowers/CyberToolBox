from youtube_transcript_api import YouTubeTranscriptApi
from youtubesearchpython import *
import os 
path = r"C:\\Users\\tsowers\\OneDrive - UKTS\Documents\\vscode\\SweetBabyGang\\" + final +'.txt'

outls = ['HXQDCGxXRjA',
         '83B2EYJEVKk',
        ]
for linkid in outls:
    try:
        vid = Video.getInfo('https://www.youtube.com/watch?v='+linkid)
        title = vid['title']
        tx = YouTubeTranscriptApi.get_transcript(linkid)
    except:
        print("Could not print " + title)
        
    for i in tx:
        outtxt = (i['text'])
        #print(outtxt)
        final = title.replace('|','~').replace('"','~').replace('?','~').replace(':','~').replace('/','~').replace('\\','~')
        path = r"C:\\Users\\tsowers\\OneDrive - UKTS\Documents\\vscode\\SweetBabyGang\\" + final +'.txt'
        with open(path, "a") as opf:
           opf.write(outtxt + "\n")
