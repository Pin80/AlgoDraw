#ifndef GRAHAM_H
#define GRAHAM_H
#include <vector>
#include <limits>
#include <math.h>
#include <algorithm>
#include <QVector>
#include <type_traits>
#include <QPointF>

class TAlgo
{
public:
template <typename T>
static void GrahamSort(std::vector<T>& _vec_inp_pt,
                       std::vector<T>& _vec_out_pt)
{
    typedef T point_t;
    using Tval = typename std::invoke_result< decltype(&T::x), T>::type ;
    class point_pred_less
    {
    public:
        bool operator()(const point_t& _pt1, const point_t& _pt2) const
        {
                const auto eps = std::numeric_limits<Tval>::epsilon();
                if (std::fabs(_pt1.x() - _pt2.x()) > eps)
                    return _pt1.x() < _pt2.x();
                else
                    return _pt1.y() < _pt2.y();
        }
    };
    class point_pred_polar
    {
    public:
        point_pred_polar(point_t _start = point_t())
            : m_pivot(_start) { m_pivot.setX(_start.x()); m_pivot.setY(_start.y());}
        bool operator()(const point_t& _pta, const point_t& _ptb) const
        {
            int order = ccw(m_pivot, _pta, _ptb);
            if (order == 0)
                return sqrDist(m_pivot, _pta) > sqrDist(m_pivot, _ptb);
            return (order == -1);
        }
        // returns -1 if a -> b -> c forms a counter-clockwise turn,
        // +1 for a clockwise turn, 0 if they are collinear
        int ccw(point_t _pta, point_t _ptb, point_t _ptc) const
        {
            Tval area = (_ptb.x() - _pta.x()) * (_ptc.y() - _pta.y()) -
                        (_ptb.y() - _pta.y()) * (_ptc.x() - _pta.x());
            if (area > 0)
                return -1;
            else if (area < 0)
                return 1;
            return 0;
        }

        // returns square of Euclidean distance between two points
        Tval sqrDist(point_t _pta, point_t _ptb) const
        {
            Tval dx = _pta.x() - _ptb.x();
            Tval dy = _pta.y() - _ptb.y();
            return dx * dx + dy * dy;
        }
    private:
        point_t m_pivot;
    };
    auto &points = _vec_inp_pt;
    const auto length = points.size();
    // find the point, which have the least y coordinate (pivot),
    // ties are broken in favor of lower x coordinate
    int leastY = 0;
    point_pred_less pred_less;
    for (int i = 0; i < length; i++)
        if (pred_less(points[i] , points[leastY]))
            leastY = i;
    auto tmp_point = points[leastY];
    points[leastY] = points[0];
    points[0] = tmp_point;

    point_pred_polar pred_polar(points[0]);
    //merge_sort<point_t, length - 1, point_pred_polar>(points + 1, pred_polar);
    auto pt_iter_start = points.begin() + 1; //points + 1
    auto pt_iter_end = points.end(); //points + length
    std::sort(pt_iter_start, pt_iter_end, pred_polar);

    //std::stack<point_t> hull;
    std::vector<point_t>& hull = _vec_out_pt;
    int res = 0;
    #define SAVE
    if (length > 0)
        hull.push_back(points[0]);
    if (length > 1)
        hull.push_back(points[1]);
    #ifdef SAVE
    if (length > 2)
        hull.push_back(points[2]); // may disable
        // i should change to 2 when no hull.push(points[2])
        for (int i = 3; i < length; i++)
    #else
        // i should change to 2 when no hull.push(points[2])
        for (int i = 2; i < length; i++)
    #endif
    {
        point_t top = hull.back();
        hull.pop_back();
        res = pred_polar.ccw(hull.back(), top, points[i]);
        while (res == 1)
        {
            top = hull.back();
            hull.pop_back();
            if (hull.empty())
            {
                //std::cerr << "internal error" << std::endl;
                return;
            }
            res = pred_polar.ccw(hull.back(), top, points[i]);
        }
        if (!res)
        {
            top = hull.back();
            hull.pop_back();
        }
        hull.push_back(top);
        hull.push_back(points[i]);
    }
}
};
#endif // GRAHAM_H
