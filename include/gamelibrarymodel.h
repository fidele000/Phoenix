
#ifndef GAMELIBRARYMODEL_H
#define GAMELIBRARYMODEL_H

#include <QSqlTableModel>

#include "librarydbmanager.h"


class GameLibraryModel: public QSqlTableModel
{
    Q_OBJECT

public:
    GameLibraryModel(LibraryDbManager *dbm, QObject *parent = 0);
    virtual ~GameLibraryModel();

    enum GameRoles {
        TitleRole = Qt::UserRole + 1,
        ConsoleRole,
        TimePlayedRole,
        ArtworkRole,
    };

    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int, QByteArray> roleNames() const override;
    virtual bool select() override;

public slots:
    void setFilter(const QString &filter, QVariantList params);
    virtual void sort(int column, Qt::SortOrder order) override
    {
        QSqlTableModel::sort(column, order);
    };

private:
    LibraryDbManager *dbm;
    QVariantList params;
    QHash<int, QByteArray> role_names;
};



#endif
