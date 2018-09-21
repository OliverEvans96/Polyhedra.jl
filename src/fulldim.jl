# -1 is the dimension of an empty polyhedron, here it is used as the
# *full* dimension of a polyhedron with no element
FullDim_rec() = -1
function FullDim_rec(rep::Rep, its::Union{Rep, It}...)
    d = FullDim(rep)
    if d == -1
        return FullDim_rec(its...)
    else
        return d
    end
end
function FullDim_rec(it::ElemIt{<:Union{AT, VStruct{T, AT},
                                        HRepElement{T, AT}}},
                     its::Union{Rep, It}...) where {T,
                                                    AT <: StaticArrays.SVector}
    return FullDim(AT)
end
function FullDim_rec(it::It, its::Union{Rep, It}...)
    if isempty(it)
        return FullDim_rec(its...)
    else
        return FullDim(first(it))
    end
end
function FullDim(::Union{HyperPlanesIntersection{T, AT},
                         LinesHull{T, AT},
                         VEmptySpace{T, AT},
                         Intersection{T, AT},
                         PointsHull{T, AT},
                         RaysHull{T, AT},
                         Hull{T, AT},
                         Interval{T, AT}}) where {T, AT <: StaticArrays.SVector}
    return FullDim(AT)
end