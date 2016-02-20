#ifndef GAMESCANNER_H
#define GAMESCANNER_H

#include "frontendcommon.h"
#include "archivefile.h"
#include "betterfuturewatcher.h"
#include "metadatadatabase.h"
#include "librarytypes.h"
#include "betterfuturewatcher.h"

<<<<<<< HEAD
#include <QObject>
=======
// Phoenix's game scanner takes advantage of MapReduce (and Qt's easy-to-use implementation of it) to efficiently and
// asyncronously scan large numbers of files
// This class holds the static methods and related structs used by the scanner to do its job
>>>>>>> b7f35c54857c5d4bb60c416756a0ed37c476910c

namespace Library {

    // Phoenix's game scanner takes advantage of MapReduce (and Qt's easy-to-use implementation of it) to efficiently and
    // asyncronously scan large numbers of files

    class GameScanner : public QObject {
            Q_OBJECT

        public:
            explicit GameScanner( QObject *parent = 0 );

            enum SearchReason {
                GetROMID,
                GetArtwork,
                GetSystemUUID,
                GetMetadata,
                GetHeaders,
            };

            qreal progress() const;
            void setProgress( qreal progress );

            // Searches the OpenVGDB or the LibretroDB, in hopes of finding metadata.
            // The search reasons are listed in the enum. Most of these are used
            // internally. The main search reason to call is GetMetadata.
            static bool searchDatabase( const SearchReason reason, FileEntry &fileEntry );

            // Step 1: Build a list of file paths from a list of file and folder paths by enumerating folders

            // If a file path, returns a single-element list containing that file path
            // Otherwise, enumerate that directory and return list of all files within
            // TODO: Recursion?
            static FileList stepOneMap( const QString &pathList );

            // Merge lists together into one main list
            static void stepOneReduce( FileList &mergedList, const FileList &givenList );

            // Step 2: Expand list of file paths by enumerating archive files, caching hashes if available

            // Enumerate archive file if given one, caching hashes if the format supports the ones we need.
            // Only archive files will have more than one entry in the return list, and only archive file formats that
            // store checksums will have cached checksum entries in the list
            static FileList stepTwoMap( const FileEntry &filePath );

            // Merge lists together into one main list
            static void stepTwoReduce( FileList &mergedList, const FileList &givenList );

            // Step 3: Eliminate redundant .bin files that were listed in .cue files
            // This is an optimization: .bin files tend to be huge and time-consuming to hash. If a .cue file that matches
            // against the database lists a bunch of .bin files that have yet to be scanned, the .bin files can be skipped

            // Enumerate .bin files in each .cue file, return the list of .bin files without checking if the .bin files exist
            // Prepend .bin file paths with directory .cue file resides in
            static FileList stepThreeMap( const FileEntry &filePath );

            // Merge lists together into one main list
            static void stepThreeReduce( FileList &mergedList, const FileList &givenList );

            // Step 4: Match file list against game database

            // Mark .bin files from main list that came from step 3's output as not needing to be scanned (cheaper than removing?)
            // FIXME: This operation is O( stepThreeOutputCount * mainListCount ) ~= O( n^2 )... bad enough it should be its own step?
            static bool stepFourFilter( const FileEntry &fileEntry );

            // Merges entries recieved from filter into a single result.
            static void stepFourFilterReduce( FileList &mergedList, const FileEntry &givenList );

            // Match against game database by hash, falling back in the following order if that misses:
            // - Filename matching, making sure the extension is valid for the system (fuzzy matching?)
            // - Header (signature/magic number) matching
            // - File extension matching
            // - Giving up (the user will have to manually match it against a system or ignore it)
            static FileList stepFourMap( const FileEntry &filePath );

            // Merge entries together into one main list
            static void stepFourReduce( FileList &mergedList, const FileList &givenEntry );

        signals:
            void progressChanged( qreal );

        public slots:

<<<<<<< HEAD
            void slotEnumeratePath( QString path );
            void stepOneFinished( BetterFutureWatcher *betterWatcher);
            void stepTwoFinished( BetterFutureWatcher *betterWatcher );
            void stepThreeFinished( BetterFutureWatcher *betterWatcher );
            void stepFourFilterFinished( BetterFutureWatcher *betterWatcher );
            void stepFourMapReduceFinished( BetterFutureWatcher *betterWatcher );

        private:
=======
        // Enumerate .bin files in each .cue file, return the list of .bin files without checking if the .bin files exist
        // Prepend .bin file paths with directory .cue file resides in
        static QStringList stepThreeMap( const FileEntry &filePath );

        // Merge lists together into one main list
        static void stepThreeReduce( QStringList &mergedList, const QStringList &givenList );
>>>>>>> b7f35c54857c5d4bb60c416756a0ed37c476910c

            // Contains a list of file paths that have been obtained by scanning the file system.

<<<<<<< HEAD
            FileList mFileList;
            QList<BetterFutureWatcher *> mWatcherList;
=======
        // Mark .bin files from main list that came from step 3's output as not needing to be scanned (cheaper than removing?)
        // FIXME: This operation is O( stepThreeOutputCount * mainListCount ) ~= O( n^2 )... bad enough it should be its own step?
        static FileList stepFourFilter( const QStringList &binList );
>>>>>>> b7f35c54857c5d4bb60c416756a0ed37c476910c

            qreal mTotalProgess;
            int mFilesProcessing;

            // Helpers
                static QString getLastExecutedQuery( const QSqlQuery &query );

                // Checks if file is a bios file, if it is the QString passed to this
                // function will be updated with the proper bios name.
                static bool isBios( QFileInfo &info, QString &biosName );

    };

<<<<<<< HEAD
}
=======
    private:
        GameScanner::FileList mFileList;
};
>>>>>>> b7f35c54857c5d4bb60c416756a0ed37c476910c

#endif // GAMESCANNER_H
