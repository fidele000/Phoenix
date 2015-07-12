#ifndef METADATADATABASE_H
#define METADATADATABASE_H

#include <QSqlDatabase>
#include <QSqlError>
#include <QDebug>
#include <QSqlQuery>
#include <QString>

namespace Library {

    // GameMetaData is used to set in metadata for any game during;
    // this usually used after the append process.
    struct GameMetaData {
        QString artworkUrl;
        QString goodToolsCode;
        QString region;
        QString developer;
        QString releaseDate;
        QString genre;
        QString description;
        QString title;
        QString filePath;
        QString identifier;
        qreal progress;
        bool updated;
    };

    class MetaDataDatabase {
        public:
            static const QString tableRoms;
            static const QString tableSystems;
            static const QString tableReleases;
            static const QString tableRegions;

            MetaDataDatabase();

            ~MetaDataDatabase();

            QSqlDatabase &database();

            void open();
            void close();

        private:
            QSqlDatabase db;

    };

}

#endif // METADATADATABASE_H