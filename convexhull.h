#ifndef CONVEXHULL_H
#define CONVEXHULL_H
#include "graham.h"
#include <QQuickPaintedItem>
#include <QAbstractListModel>

class TConvexHullModel : public QAbstractListModel
{
    using ITEM = QPoint;
    using ITEM2 = QColor;
    Q_OBJECT
public:
    enum CollectionRole {
        coordRole = Qt::UserRole + 1,
        colorRole = Qt::UserRole + 2
    };
    TConvexHullModel()
    {
        const char ITEM_ROLE_CRD[] = "mcoord";
        const char ITEM_ROLE_COLOR[] = "mcolor";
        m_roles[coordRole] = ITEM_ROLE_CRD;
        m_roles[colorRole] = ITEM_ROLE_COLOR;
    }
    Q_INVOKABLE void setCHPoints(const QVariant& _ptlist);
    Q_PROPERTY(int count READ getcount NOTIFY changed)
    int getcount() const
    {
        return m_modellist.count();
    }
    Q_PROPERTY(bool ptset READ getPtset WRITE setPtset NOTIFY ptsetChanged)
    bool getPtset() const { return m_isptset;}
    void setPtset(bool _ptset)
    {
        m_isptset = _ptset;
        emit ptsetChanged();
    }
    int rowCount( const QModelIndex& parent ) const override
    {
        Q_UNUSED( parent )
        return m_modellist.count();
    }

    QVariant data( const QModelIndex& index, int role ) const override;
    Q_INVOKABLE
    QPointF get( const int& index ) const
    {
        auto row = index;
        if ( row < 0 || row >= m_modellist.count() )
            return QPointF();
        return ( m_modellist.at( row ) );
    }

    QHash<int, QByteArray> roleNames() const override
    {
        return m_roles;
    }
    Q_INVOKABLE
    void append( const ITEM& item )
    {
        auto i = m_modellist.count();
        beginInsertRows( m_root_model_idx, i, i );
        m_modellist.append( item );
        endInsertRows();
        emitChanged();
    }
    Q_INVOKABLE
    void clear()
    {
        beginResetModel();
        m_modellist.clear();
        m_sourcelist.clear();
        m_isptset = false;
        endResetModel();
        emitChanged();
    }
    static TConvexHullModel *getInstance(QQmlEngine *engine,
                                         QJSEngine *scriptEngine);
Q_SIGNALS:
    void changed(int);
    void ptsetChanged();

protected:
    virtual void emitChanged()
    {
        emit ptsetChanged();
        emit changed(m_modellist.count());
    }
private:
    QVector<ITEM> m_modellist;
    QVector<ITEM> m_sourcelist;
    QHash<int, QByteArray> m_roles;
    QModelIndex m_root_model_idx;
    bool m_isptset = false;
};


#endif // CONVEXHULL_H
