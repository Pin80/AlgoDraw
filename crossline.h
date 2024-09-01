#ifndef CROSSLINE_H
#define CROSSLINE_H
#include <iostream>
#include <vector>
#include <math.h>
#include <QObject>
#include <QPointF>
#include <QVariant>
#include <QVector3D>

class TCrossline: public QObject
{
    Q_OBJECT
private:
    bool m_iscrossed = false;
    QPointF m_point;
public:
    Q_PROPERTY(bool iscrossed READ isCrossed WRITE setCrossed NOTIFY crossedChanged)
    float isCrossed() const { return m_iscrossed;}
    Q_PROPERTY(QPointF crosspt READ getCrossed  NOTIFY crossedptChanged)
    QPointF getCrossed() const { return m_point; }
    void setCrossed(bool _val) { m_iscrossed = _val; }
    TCrossline(QObject *_pq = nullptr);
    Q_INVOKABLE void testCrossed(const QVariant& _ptlist);
signals:
    void crossedChanged();
    void crossedptChanged();
private:
    void are_crossing(const QPointF& v11,
                      const QPointF& v12,
                      const QPointF& v21,
                      const QPointF& v22);
};

#endif // CROSSLINE_H
