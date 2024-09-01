#include "crossline.h"

TCrossline::TCrossline(QObject *_pq)
    : QObject(_pq)
{ }

void TCrossline::testCrossed(const QVariant &_ptlist)
{
    QPointF pt1, pt2, pt3, pt4;
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
    if (ptlist[3].canConvert(QMetaType::QPointF))
        pt4 = ptlist[3].toPointF();
    else
        return;
    are_crossing(pt1, pt2, pt3, pt4);
    emit crossedChanged();
    emit crossedptChanged();
}

void TCrossline::are_crossing(const QPointF &v11,
                              const QPointF &v12,
                              const QPointF &v21,
                              const QPointF &v22)
{
   QVector3D cut1(v12-v11), cut2(v22-v21); //cut1(v12-v11), cut2(v22-v21);
   QVector3D cut3(v21-v11), cut4(v22-v11);
   QVector3D cut5(v11-v21), cut6(v12-v21);
   QVector3D prod1, prod2;
   m_iscrossed = false;
   //prod1 = cross(cut1 * (v21-v11));
   //prod2 = cross(cut1 * (v22-v11));
   prod1 = QVector3D::crossProduct(cut1, cut3);
   prod2 = QVector3D::crossProduct(cut1, cut4);

   if ( (std::signbit(prod1.z()) == std::signbit(prod2.z())) ||
        (prod1.z() == 0) || prod2.z() == 0)
       return;

   //prod1 = cross(cut2 * (v11-v21));
   //prod2 = cross(cut2 * (v12-v21));
   prod1 = QVector3D::crossProduct(cut2, cut5);
   prod2 = QVector3D::crossProduct(cut2, cut6);

   if ( (std::signbit(prod1.z()) == std::signbit(prod2.z())) ||
        (prod1.z() == 0) || prod2.z() == 0)
        return;

   m_point.setX(v11.x() + cut1.x() * fabs(prod1.z()/fabs(prod2.z() - prod1.z())));
   m_point.setY(v11.y() + cut1.y() * fabs(prod1.z()/fabs(prod2.z() - prod1.z())));
   m_iscrossed = true;
   return;
}
