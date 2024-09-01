#ifndef TELLIPSE_H
#define TELLIPSE_H
#include <QQuickPaintedItem>
class QPainter;

class TArcDraw: public QObject
{
    Q_OBJECT
private:
    Q_PROPERTY (QColor color WRITE setColorValue READ colorValue)
    QColor m_color;
    bool m_isptset = false;
    float m_h, m_k, m_r = 0;
public:
    Q_PROPERTY(float h READ getH NOTIFY gethChanged)
    float getH() const { return m_h;}
    Q_PROPERTY(float k READ getK NOTIFY getkChanged)
    float getK() const { return m_k;}
    Q_PROPERTY(float r READ getR NOTIFY getrChanged)
    float getR() const { return m_r;}
    Q_PROPERTY(bool ptset READ getPtset WRITE setPtset NOTIFY ptsetChanged)
    bool getPtset() const { return m_isptset;}
    void setPtset(bool _ptset)
    {
        m_isptset = _ptset;
        emit ptsetChanged();
    }
    TArcDraw(QObject *_pq = nullptr);
    QColor colorValue() const;
    void setColorValue(const QColor& _color);
    Q_INVOKABLE void setArcPoints(const QVariant& _ptlist);
signals:
    void gethChanged();
    void getkChanged();
    void getrChanged();
    void ptsetChanged();

};

#endif // TELLIPSE_H
