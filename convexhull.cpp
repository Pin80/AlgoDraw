#include "convexhull.h"

void TConvexHullModel::setCHPoints(const QVariant &_ptlist)
{
    if (!_ptlist.canConvert(QMetaType::QVariantList))
        return;
    QList<QVariant> ptlist = _ptlist.toList();
    if (ptlist.size() < 3)
        return;
    for(const QVariant& var: ptlist)
    {
        if (var.canConvert(QMetaType::QPoint))
            m_sourcelist.append( var.toPoint());
        else
            return;
    }
    std::vector<ITEM> istdvector = m_sourcelist.toStdVector();
    std::vector<ITEM> ostdvector;
    TAlgo algo;
    algo.GrahamSort<ITEM>(istdvector, ostdvector);
    beginInsertRows( m_root_model_idx, 0, ostdvector.size()  );
    m_modellist = m_modellist.fromStdVector(ostdvector);
    m_modellist.push_back(m_modellist.at(0));
    endResetModel();
    m_isptset = true;
    emitChanged();
}

QVariant TConvexHullModel::data(const QModelIndex &index, int role) const
{
    auto row = index.row();
    if ( row < 0 || row >= m_modellist.count() )
        return QVariant();
    if ( role == coordRole )
    {
        return QVariant::fromValue<ITEM>( m_modellist.at( row ) );
    }
    if ( role == colorRole )
    {
        return QVariant::fromValue<ITEM2>( QColor("green") );
    }
    return QVariant();
}

TConvexHullModel* TConvexHullModel::getInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    static TConvexHullModel * pinstance = new TConvexHullModel();
    //m_instance = pinstance;
    return pinstance;
}
