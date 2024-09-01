#include "arcdraw.h"
#include <QPainter>
#include <math.h>

TArcDraw::TArcDraw(QObject *_pq)
    : QObject(_pq), m_color(Qt::black)
{ }

QColor TArcDraw::colorValue() const
{
    return m_color;
}

void TArcDraw::setColorValue(const QColor &_color)
{
    m_color = _color;
}

void TArcDraw::setArcPoints(const QVariant& _ptlist)
{
    QPointF pt1, pt2, pt3;
    if (!_ptlist.canConvert(QMetaType::QVariantList))
        return;
    QList<QVariant> ptlist = _ptlist.toList();
    if (ptlist.size() < 3)
        return;
    if (ptlist[0].canConvert(QMetaType::QPointF))
        pt1 = ptlist[0].toPointF();
    else
        return;
    if (ptlist[1].canConvert(QMetaType::QPointF))
        pt2 = ptlist[1].toPointF();
    else
        return;
    if (ptlist[2].canConvert(QMetaType::QPointF))
        pt3 = ptlist[2].toPointF();
    else
        return;
    bool found_h = false, found_k = false;
    float a[3];
    float bh[3];
    float bk[3];
    const float eps = 0.0001;
    {
        a[0] = ((pt2.x()*pt2.x()) - (pt1.x()*pt1.x()) + (pt2.y()*pt2.y()) - (pt1.y()*pt1.y()))/2;
        a[1] = ((pt3.x()*pt3.x()) - (pt2.x()*pt2.x()) + (pt3.y()*pt3.y()) - (pt2.y()*pt2.y()))/2;
        a[2] = ((pt3.x()*pt3.x()) - (pt1.x()*pt1.x()) + (pt3.y()*pt3.y()) - (pt1.y()*pt1.y()))/2;
        float dx32 = pt3.x() - pt2.x();
        float dy21 = pt2.y() - pt1.y();
        float dy32 = pt3.y() - pt2.y();
        float dx21 = pt2.x() - pt1.x();

        float dx31 = pt3.x() - pt1.x();
        float dy31 = pt3.y() - pt1.y();

        bh[0] = dx32*dy21 - dy32*dx21;
        bh[1] = dx31*dy32 - dx32*dy31;
        bh[2] = dx31*dy21 - dx21*dy31;

        bk[0] = dy32*dx21 - dy21*dx32;
        bk[1] = dy31*dx32 - dy32*dx31;
        bk[2] = dy31*dx21 - dy21*dx31;
        if (bh[0] > eps)
        {
            m_h = (a[1]*dy21 - a[0]*dy32)/bh[0];
            found_h = true;
        }
        else
        if (bh[1] > eps)
        {
            m_h = (a[2]*dy32 - a[1]*dy31)/bh[1];
            found_h = true;
        }
        else
        if (bh[2] > eps)
        {
            m_h = (a[2]*dy21 - a[0]*dy31)/bh[2];
            found_h = true;
        }
        if (bk[0] > eps)
        {
            m_k = (a[1]*dx21 - a[0]*dx32)/bk[0];
            found_k = true;
        }
        else
        if (bk[1] > eps)
        {
            m_k = (a[2]*dx32 - a[1]*dx31)/bk[1];
            found_k = true;
        }
        else
        if (bk[2] > eps)
        {
            m_k = (a[2]*dx21 - a[0]*dx31)/bk[2];
            found_k = true;
        }
    }
    if (found_h && found_k)
    {
        m_isptset = true;
        m_r = sqrt((pt1.x() - m_h)*(pt1.x() - m_h) + (pt1.y() - m_k)*(pt1.y() - m_k));
        emit ptsetChanged();
        emit getrChanged();
        return;
    }
    m_isptset = false;
}
